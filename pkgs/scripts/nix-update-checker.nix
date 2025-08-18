#NOTE: Converted from: https://github.com/guttermonk/waybar-nixos-updates
# Utilized by waybar
{
  pkgs,
  custom_vars,
}: let
  UPDATE_INTERVAL_SECONDS = 1800;
  NIXOS_CONFIG_PATH = custom_vars.NIXOS_CONF_PATH;
  CACHE_DIR = custom_vars.CACHE_DIR;

  ICON_PATH = "${custom_vars.NIXOS_ASSETS_PATH}/Icons/waybar/nixos-updates";

  #INFO: The grace period prevents the update checker from running immediately after:
  # 1. First boot - when the system has just started up
  # 2. Resume from hibernation/suspension - when the system has just woken up
  # This avoids unnecessary resource usage and notifications during these transition periods.

  SKIP_AFTER_BOOT = true; # Set to false if you want to run the checker even after boot/resume
  GRACE_PERIOD = 60; # Grace period in seconds (60 seconds) after boot/resume

  #INFO: If true, update the lock file in the config folder.
  # If false, copy config to temp folder first, and then update the temp dir's lock file.
  UPDATE_LOCK_FILE = false;
in
  pkgs.writeShellApplication {
    name = "nix-update-checker";

    #NOTE: Tools used in the script
    runtimeInputs = [
      pkgs.nix
      pkgs.nvd # nvd diff
      pkgs.coreutils # date, mktemp, etc.
      pkgs.gnused # sed
      pkgs.gnugrep # grep
      pkgs.gawk # awk
      pkgs.procps # pkill
      pkgs.iputils # ping
      pkgs.systemd # journalctl
      pkgs.libnotify # notify-send
    ];
    text = ''
      # NixOS Update Checker for Waybar
      # This script checks for NixOS updates and outputs JSON for Waybar integration

      # ===== Configuration =====
      UPDATE_INTERVAL=${toString UPDATE_INTERVAL_SECONDS}  # Check interval in seconds (1 hour)
      NIXOS_CONFIG_PATH="${NIXOS_CONFIG_PATH}"  # Path to NixOS configuration
      CACHE_DIR="${CACHE_DIR}"
      STATE_FILE="$CACHE_DIR/nix-update-state"
      LAST_RUN_FILE="$CACHE_DIR/nix-update-last-run"
      LAST_RUN_TOOLTIP="$CACHE_DIR/nix-update-tooltip"
      BOOT_MARKER_FILE="$CACHE_DIR/nix-update-boot-marker"  # Marker file to detect boot/resume

      SKIP_AFTER_BOOT=${toString SKIP_AFTER_BOOT}
      GRACE_PERIOD=${toString GRACE_PERIOD}

      UPDATE_LOCK_FILE="${toString UPDATE_LOCK_FILE}"

      # If you have a separate script to update your lock file (i.e. "nix flake update" script)
      # and you have UPDATE_LOCK_FILE set to "false",
      # the UPDATE_FLAG will signal that your lock file has been updated.
      # Add the following to your update script so that the output of nvd diff is piped in:
      # | tee >(if grep -qe '\\[U'; then touch \"$HOME/.cache/nix-update-update-flag\"; else rm -f \"$HOME/.cache/nix-update-update-flag\"; fi) &&
      UPDATE_FLAG="$CACHE_DIR/nix-update-update-flag"

      # The REBUILD_FLAG signals this script to run after your system has been rebuilt.
      # Add this to your update script:
      # if [ -f \"$HOME/.cache/nix-update-update-flag\" ]; then touch \"$HOME/.cache/nix-update-rebuild-flag\" && pkill -x -RTMIN+12 .waybar-wrapped; fi &&
      REBUILD_FLAG="$CACHE_DIR/nix-update-rebuild-flag"

      # The UPDATING_FLAG signals if upgrade process is currently performing
      # This is required to force waybar module to render while we wait for nixos rebuild
      # and also this is enhances UI/UX side
      UPDATING_FLAG="$CACHE_DIR/nix-update-updating-flag"


      # ===== Initialize Files =====
      mkdir -p "$CACHE_DIR"

      function init_files() {
          # Create the state file if it doesn't exist
          if [ ! -f "$STATE_FILE" ]; then
              echo "0" > "$STATE_FILE"
          fi

          # Create the last run file if it doesn't exist
          if [ ! -f "$LAST_RUN_FILE" ]; then
              echo "0" > "$LAST_RUN_FILE"
          fi

          # Create the tooltip file if it doesn't exist
          if [ ! -f "$LAST_RUN_TOOLTIP" ]; then
              updates=$(cat "$STATE_FILE")
              if [ "$updates" -eq 0 ]; then
                  echo "System updated" > "$LAST_RUN_TOOLTIP"
              else
                  # Will be populated during update check
                  echo "" > "$LAST_RUN_TOOLTIP"
              fi
          fi
      }

      # ===== Helper Functions =====
      function send_notification() {
          local title message icon
          icon="$1"
          title="$2"
          message="$3"
          if command -v dunstify >/dev/null 2>&1; then
            dunstify "$@" -i "${ICON_PATH}/$icon.png" "$title" "$message"
          else
            notify-send "$@" -i "${ICON_PATH}/$icon.png" "$title" "$message"
          fi
      }

      function check_boot_resume() {
              # This function detects if the system has recently booted or resumed from hibernation/sleep
              # Returns 0 (true) if we're in the grace period, 1 (false) otherwise
              local last_boot_time
              local uptime_seconds
              local current_time
              local last_resume
              local resume_log

              current_time=$(date +%s)
              uptime_seconds=$(awk '{print int($1)}' /proc/uptime)
              last_boot_time=$((current_time - uptime_seconds))

              # Check if this is first run after boot
              if [ ! -f "$BOOT_MARKER_FILE" ] || [ $((current_time - last_boot_time)) -lt "$GRACE_PERIOD" ]; then
                  # We're either in first run or within grace period after boot
                  echo "$current_time" > "$BOOT_MARKER_FILE"
                  return 0
              fi

              # Initialize resume timestamp
              last_resume=0

              # Try to detect resume using systemd logs
              if command -v journalctl >/dev/null 2>&1; then
                  local resume_log
                  # Get timestamp of last resume/wakeup event from systemd journal
                  resume_log=$(journalctl -b -u systemd-suspend.service -u systemd-hibernate.service -n 1 -o short-unix 2>/dev/null)
                  if [ -n "$resume_log" ]; then
                      local timestamp
                      # Extract just the numeric timestamp from the beginning of the line
                      timestamp=$(echo "$resume_log" | sed -E 's/^([0-9]+).*/\1/')
                      if [ -n "$timestamp" ] && [[ "$timestamp" =~ ^[0-9]+$ ]]; then
                          last_resume=$timestamp
                      fi
                  fi

                  # If no direct service logs, try looking for resume messages in kernel logs
                  if [ "$last_resume" -eq 0 ]; then
                      local wake_log
                      wake_log=$(journalctl -b -k -g "PM: resumed" -n 1 -o short-unix 2>/dev/null)
                      if [ -n "$wake_log" ]; then
                          # Extract just the numeric timestamp from the beginning of the line
                          local timestamp
                          timestamp=$(echo "$wake_log" | sed -E 's/^([0-9]+).*/\1/')
                          if [ -n "$timestamp" ] && [[ "$timestamp" =~ ^[0-9]+$ ]]; then
                              last_resume=$timestamp
                          fi
                      fi
                  fi
              fi

              # Check if we can find resume info in NixOS-specific locations
              if [ "$last_resume" -eq 0 ] && [ -d "/run/systemd/system" ]; then
                  # Check systemd sleep state
                  if [ -f "/run/systemd/suspend/active" ] || [ -f "/run/systemd/hibernate/active" ]; then
                      last_resume=$current_time  # Just woke up
                  fi
              fi

              # If we detected a resume and it's recent, we're in grace period
              if [ "$last_resume" -gt 0 ] && [ $((current_time - last_resume)) -lt "$GRACE_PERIOD" ]; then
                  echo "$current_time" > "$BOOT_MARKER_FILE"
                  return 0
              fi

              # Check if we have a saved boot marker and we're still in grace period
              if [ -f "$BOOT_MARKER_FILE" ]; then
                  local marker_time
                  marker_time=$(cat "$BOOT_MARKER_FILE")
                  if [[ "$marker_time" =~ ^[0-9]+$ ]] && [ $((current_time - marker_time)) -lt "$GRACE_PERIOD" ]; then
                      return 0  # Still in grace period from marker
                  fi
              fi

              # Not in grace period
              return 1
          }

      function check_network_connectivity() {
          # Check if either ethernet or wireless is connected
          if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
              return 0  # Connected to the internet
          else
              return 1  # Not connected to the internet
          fi
      }

      function sys_updated() {
        if [ -f "$REBUILD_FLAG" ]; then
          return 0 # System has been updated
        else
          return 1 # System has not been updated
        fi
      }

      function calc_next_update() {
          local last_run next_update next_update_min current_time

          last_run=$(cat "$LAST_RUN_FILE")
          current_time=$(date +%s)
          next_update=$((UPDATE_INTERVAL - (current_time - last_run)))
          if [ "$next_update" -lt 0 ]; then next_update=0; fi
          next_update_min=$((next_update / 60))
          echo "$next_update_min"
      }

      function var_setter() {
          if [ "$updates" -ne 0 ]; then
              alt="has-updates"
              tooltip=$(cat "$LAST_RUN_TOOLTIP")
          else
              alt="updated"
              tooltip="System updated"
          fi
      }

      # ===== Update Check Logic =====
      function check_for_updates() {
          local tempdir
          local updates
          local tooltip

          tempdir=$(mktemp -d)
          # Ensure cleanup happens when script exits
          trap 'if [ -n "''${tempdir:-}" ]; then rm -rf -- "$tempdir"; fi' EXIT

          send_notification "updates-checking" "Checking for Updates" "Please be patient"

          updates=0
          tooltip=""

          if [ "$UPDATE_LOCK_FILE" = "true" ]; then
              # Use the config directory directly
              cd "$NIXOS_CONFIG_PATH" || return 1
              nix flake update >/dev/null 2>&1k
              # Capture stderr and extract the error line
              if build_output=$(nix build ".#nixosConfigurations.$(hostname).config.system.build.toplevel" 2>&1); then
                  updates=$(nvd diff /run/current-system ./result | grep -c '\[U')
                  tooltip=$(nvd diff /run/current-system ./result | grep -e '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n' | sed 's/\\n$//')
              else
                  # Extract just the error line starting with "error:"
                  error_line=$(echo "$build_output" | grep "^       error:" | head -1 | sed 's/^[[:space:]]*//')
                  echo "$error_line" > "$LAST_RUN_TOOLTIP"
                  return 1
              fi
          else
              # Use a temp directory to avoid modifying lock file
              cp -a "$NIXOS_CONFIG_PATH"/. "$tempdir"/
              cd "$tempdir" || return 1
              nix flake update >/dev/null 2>&1
              # Capture stderr and extract the error line
              if build_output=$(nix build ".#nixosConfigurations.$(hostname).config.system.build.toplevel" 2>&1); then
                  updates=$(nvd diff /run/current-system ./result | grep -c '\[U' )
                  tooltip=$(nvd diff /run/current-system ./result | grep -e '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n' | sed 's/\\n$//')
              else
                  # Extract just the error line starting with "error:"
                  error_line=$(echo "$build_output" | grep "^       error:" | head -1 | sed 's/^[[:space:]]*//')
                  echo "$error_line" > "$LAST_RUN_TOOLTIP"
                  return 1
              fi
          fi

          # Save results
          echo "$updates" > "$STATE_FILE"
          date +%s > "$LAST_RUN_FILE"

          if [ "$updates" -eq 0 ]; then
              echo "System updated" > "$LAST_RUN_TOOLTIP"
              send_notification "updates-complete" "Update Check Complete" "No updates available"
          elif [ "$updates" -eq 1 ]; then
              echo "$tooltip" > "$LAST_RUN_TOOLTIP"
              send_notification "updates-pending" "Update Check Complete" "Found 1 update"
          else
              echo "$tooltip" > "$LAST_RUN_TOOLTIP"
              send_notification "updates-pending" "Update Check Complete" "Found $updates updates"
          fi

          return 0
      }

      # ===== Main Function =====
      function main() {
          init_files

          # Check if we're in post-boot/resume grace period
          if [ "$SKIP_AFTER_BOOT" = "true" ] && check_boot_resume; then
              # Skip update check during grace period after boot or resume from hibernation
              # This prevents unnecessary resource usage during system startup or wakeup
              updates=$(cat "$STATE_FILE")
              var_setter
              echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
              exit 0
          fi

          # Check for network connectivity before proceeding
          if check_network_connectivity; then
            local updates
            local alt
            local tooltip

            updates=0
            alt=""
            tooltip=""

            # Delete flags if system was just updated
            if sys_updated; then
                updates=0
                alt="updated"
                tooltip="System updated"
                echo "$updates" > "$STATE_FILE"
                echo "$tooltip" > "$LAST_RUN_TOOLTIP"
                if [ -f "$UPDATE_FLAG" ]; then
                  rm "$UPDATE_FLAG"
                fi
                rm "$REBUILD_FLAG"
            else
                # Read state from files
                local current_time
                local last_run

                updates=$(cat "$STATE_FILE")
                last_run=$(cat "$LAST_RUN_FILE")
                current_time=$(date +%s)

                # Decide whether to show saved state or perform new check
                if [ $((current_time - last_run)) -gt "$UPDATE_INTERVAL" ]; then
                    # Separating updating and updated phase
                    if [ -f "$UPDATING_FLAG" ]; then
                        # Time to check for updates
                        if check_for_updates; then
                            updates=$(cat "$STATE_FILE")
                            var_setter
                        else
                            # Update check failed - read the full error from tooltip file
                            updates=""
                            alt="error"
                            tooltip=$(cat "$LAST_RUN_TOOLTIP")
                            send_notification "updates-failed" "Update Check Failed" "Check tooltip for detailed error message"
                        fi
                        rm "$UPDATING_FLAG"
                    else
                        updates=$(cat "$STATE_FILE")
                        alt="updating"
                        tooltip="Checking for updates"
                        touch "$UPDATING_FLAG"
                        # Rerun same script just to show updating status and
                        # run update process in separate thread
                        pkill -x -RTMIN+12 .waybar-wrapped
                    fi
                else
                    # Use saved state
                    send_notification "updates-wait" "Please Wait" "Next update is in $(calc_next_update) min."
                    var_setter
                fi
            fi
          else
              updates=$(cat "$STATE_FILE")
              var_setter
              send_notification "updates-failed" "Update Check Failed" "Not connected to the internet"
          fi

          # Output JSON for Waybar
          echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
      }


      # Execute main function
      main
    '';
  }
