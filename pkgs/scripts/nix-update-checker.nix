#NOTE: Converted from: https://github.com/guttermonk/waybar-nixos-updates
# Utilized by waybar
{
  pkgs,
  config,
}: let
  UPDATE_INTERVAL_SECONDS = 3600; # 1 hour
  NIXOS_CONFIG_PATH = config.x0.nixosConfPath;
  CACHE_DIR = config.x0.cachePath;
  ICON_PATH = "${config.x0.nixosAssetsPath}/Icons/waybar/nixos-updates";

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
      pkgs.inetutils # hostname
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
      # ===== Configuration =====
      UPDATE_INTERVAL=${toString UPDATE_INTERVAL_SECONDS}
      NIXOS_CONFIG_PATH="${NIXOS_CONFIG_PATH}"
      CACHE_DIR="${CACHE_DIR}"
      STATE_FILE="$CACHE_DIR/nix-update-state"
      LAST_RUN_FILE="$CACHE_DIR/nix-update-last-run"
      LAST_RUN_TOOLTIP="$CACHE_DIR/nix-update-tooltip"
      BOOT_MARKER_FILE="$CACHE_DIR/nix-update-boot-marker"

      SKIP_AFTER_BOOT=${toString SKIP_AFTER_BOOT}
      GRACE_PERIOD=${toString GRACE_PERIOD}
      # WARN: uncomment if new check_for_updates function does not function correctly
      # UPDATE_LOCK_FILE="${toString UPDATE_LOCK_FILE}"

      UPDATE_FLAG="$CACHE_DIR/nix-update-update-flag"
      REBUILD_FLAG="$CACHE_DIR/nix-update-rebuild-flag"
      UPDATING_FLAG="$CACHE_DIR/nix-update-updating-flag"

      mkdir -p "$CACHE_DIR"

      init_files() {
        [ -f "$STATE_FILE" ] || echo 0 > "$STATE_FILE"
        [ -f "$LAST_RUN_FILE" ] || echo 0 > "$LAST_RUN_FILE"
        if [ ! -f "$LAST_RUN_TOOLTIP" ]; then
          if [ "$(cat "$STATE_FILE")" -eq 0 ]; then
            echo "System updated" > "$LAST_RUN_TOOLTIP"
          else
            : > "$LAST_RUN_TOOLTIP"
          fi
        fi
      }

      send_notification() {
        local icon="$1" title="$2" message="$3"
        shift 3
        if command -v dunstify >/dev/null 2>&1; then
          dunstify "$@" -i "${ICON_PATH}/$icon.png" "$title" "$message"
        else
          notify-send "$@" -i "${ICON_PATH}/$icon.png" "$title" "$message"
        fi
      }

      check_boot_resume() {
        local current_time uptime_seconds last_boot_time last_resume resume_log
        current_time=$(date +%s)
        uptime_seconds=$(awk '{print int($1)}' /proc/uptime)
        last_boot_time=$((current_time - uptime_seconds))

        if [ ! -f "$BOOT_MARKER_FILE" ] || [ $((current_time - last_boot_time)) -lt "$GRACE_PERIOD" ]; then
          echo "$current_time" > "$BOOT_MARKER_FILE"; return 0
        fi

        last_resume=0
        if command -v journalctl >/dev/null 2>&1; then
          resume_log=$(journalctl -b -u systemd-suspend.service -u systemd-hibernate.service -n 1 -o short-unix 2>/dev/null || true)
          if [ -n "$resume_log" ]; then
            local ts; ts=$(echo "$resume_log" | sed -E 's/^([0-9]+).*/\1/'); [[ "$ts" =~ ^[0-9]+$ ]] && last_resume=$ts
          fi
          if [ "$last_resume" -eq 0 ]; then
            local wake_log; wake_log=$(journalctl -b -k -g "PM: resumed" -n 1 -o short-unix 2>/dev/null || true)
            if [ -n "$wake_log" ]; then
              local ts; ts=$(echo "$wake_log" | sed -E 's/^([0-9]+).*/\1/'); [[ "$ts" =~ ^[0-9]+$ ]] && last_resume=$ts
            fi
          fi
        fi

        if [ "$last_resume" -eq 0 ] && [ -d /run/systemd/system ]; then
          if [ -f /run/systemd/suspend/active ] || [ -f /run/systemd/hibernate/active ]; then
            last_resume=$current_time
          fi
        fi

        if [ "$last_resume" -gt 0 ] && [ $((current_time - last_resume)) -lt "$GRACE_PERIOD" ]; then
          echo "$current_time" > "$BOOT_MARKER_FILE"; return 0
        fi

        if [ -f "$BOOT_MARKER_FILE" ]; then
          local marker_time; marker_time=$(cat "$BOOT_MARKER_FILE")
          if [[ "$marker_time" =~ ^[0-9]+$ ]] && [ $((current_time - marker_time)) -lt "$GRACE_PERIOD" ]; then
            return 0
          fi
        fi
        return 1
      }

      check_network_connectivity() {
        ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1
      }

      sys_updated() {
        [ -f "$REBUILD_FLAG" ]
      }

      calc_next_update() {
        local last_run current_time next_update next_update_min
        last_run=$(cat "$LAST_RUN_FILE")
        current_time=$(date +%s)
        next_update=$((UPDATE_INTERVAL - (current_time - last_run)))
        [ "$next_update" -lt 0 ] && next_update=0
        next_update_min=$((next_update / 60))
        echo "$next_update_min"
      }

      var_setter() {
        if [ "$updates" -ne 0 ]; then
          alt="has-updates"; tooltip=$(cat "$LAST_RUN_TOOLTIP")
        else
          alt="updated"; tooltip="System updated"
        fi
      }

      # WARN: uncomment this whole block if the new check_for_updates function does not function correctly

      # check_for_updates() {
      #   local tempdir updates tooltip
      #   tempdir=$(mktemp -d)
      #   trap 'if [ -n "''${tempdir:-}" ]; then rm -rf -- "$tempdir"; fi' EXIT
      #
      #   send_notification "updates-checking" "Checking for Updates" "Please be patient" -t 2000
      #   updates=0; tooltip=""
      #
      #   if [ "$UPDATE_LOCK_FILE" = "true" ]; then
      #     cd "$NIXOS_CONFIG_PATH" || return 1
      #     nix flake update >/dev/null 2>&1
      #     if build_output=$(nix build ".#nixosConfigurations.$(hostname).config.system.build.toplevel" 2>&1); then
      #       updates=$(nvd diff /run/current-system ./result | grep -c '\[U')
      #       tooltip=$(nvd diff /run/current-system ./result | grep -e '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\n' | sed 's/\n$//')
      #     else
      #       error_line=$(echo "$build_output" | grep "^       error:" | head -1 | sed 's/^[[:space:]]*//')
      #       echo "$error_line" > "$LAST_RUN_TOOLTIP"; return 1
      #     fi
      #   else
      #     cp -a "$NIXOS_CONFIG_PATH"/. "$tempdir"/
      #     cd "$tempdir" || return 1
      #     nix flake update >/dev/null 2>&1
      #     if build_output=$(nix build ".#nixosConfigurations.$(hostname).config.system.build.toplevel" 2>&1); then
      #       updates=$(nvd diff /run/current-system ./result | grep -c '\[U')
      #       tooltip=$(nvd diff /run/current-system ./result | grep -e '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\n' | sed 's/\n$//')
      #     else
      #       error_line=$(echo "$build_output" | grep "^       error:" | head -1 | sed 's/^[[:space:]]*//')
      #       echo "$error_line" > "$LAST_RUN_TOOLTIP"; return 1
      #     fi
      #   fi
      #
      #   echo "$updates" > "$STATE_FILE"
      #   date +%s > "$LAST_RUN_FILE"
      #
      #   if [ "$updates" -eq 0 ]; then
      #     echo "System updated" > "$LAST_RUN_TOOLTIP"
      #     send_notification "updates-complete" "Update Check Complete" "No updates available" -t 2000
      #   elif [ "$updates" -eq 1 ]; then
      #     echo "$tooltip" > "$LAST_RUN_TOOLTIP"
      #     send_notification "updates-pending" "Update Check Complete" "Found 1 update" -t 2000
      #   else
      #     echo "$tooltip" > "$LAST_RUN_TOOLTIP"
      #     send_notification "updates-pending" "Update Check Complete" "Found $updates updates" -t 2000
      #   fi
      #   return 0
      # }


      check_for_updates() {
        local tempdir updates tooltip before after
        tempdir=$(mktemp -d)
        trap 'rm -rf -- "$tempdir"' EXIT

        send_notification "updates-checking" "Checking for Updates" "Please be patient" -t 2000
        updates=0; tooltip=""

        # Work in a throwaway copy; never touch your repo
        cp -a "$NIXOS_CONFIG_PATH"/. "$tempdir"/
        cd "$tempdir" || return 1

        # Snapshot the current lock (input@rev or lastModified)
        before=$(jq -r '
          .nodes
          | to_entries
          | map(select(.value.locked and (.value.locked.rev or .value.locked.lastModified)))
          | map("\(.key)@\(.value.locked.rev//.value.locked.lastModified)")
          | .[]
        ' flake.lock 2>/dev/null)

        # Update only the temp lockfile to see what *would* change
        if ! nix flake update --accept-flake-config >/dev/null 2>&1; then
          echo "flake update failed" > "$LAST_RUN_TOOLTIP"
          return 1
        fi

        after=$(jq -r '
          .nodes
          | to_entries
          | map(select(.value.locked and (.value.locked.rev or .value.locked.lastModified)))
          | map("\(.key)@\(.value.locked.rev//.value.locked.lastModified)")
          | .[]
        ' flake.lock 2>/dev/null)

        # Compute changed input names
        # (lines that differ between before and after by name or rev)
        changed=$(diff -u <(printf "%s\n" "$before" | sort) <(printf "%s\n" "$after" | sort) \
                  | grep -E '^[+-][^+-]' | sed 's/^[+-]//' | cut -d'@' -f1 | sort -u)

        if [ -z "$changed" ]; then
          updates=0
          tooltip="System updated"
          send_notification "updates-complete" "Update Check Complete" "No updates available" -t 2000
        else
          updates=$(printf "%s\n" "$changed" | wc -l | awk '{print $1}')
          tooltip=$(printf "%s\n" "$changed")
          if [ "$updates" -eq 1 ]; then
            send_notification "updates-pending" "Update Check Complete" "Found 1 input update" -t 2000
          else
            send_notification "updates-pending" "Update Check Complete" "Found $updates input updates" -t 2000
          fi
        fi

        echo "$updates" > "$STATE_FILE"
        date +%s > "$LAST_RUN_FILE"
        echo "$tooltip" > "$LAST_RUN_TOOLTIP"
        return 0
      }

      main() {
        init_files

        if [ "$SKIP_AFTER_BOOT" = "true" ] && check_boot_resume; then
          updates=$(cat "$STATE_FILE"); var_setter
          echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"; exit 0
        fi

        if check_network_connectivity; then
          local updates alt tooltip
          updates=0; alt=""; tooltip=""

          if sys_updated; then
            updates=0; alt="updated"; tooltip="System updated"
            echo "$updates" > "$STATE_FILE"
            echo "$tooltip" > "$LAST_RUN_TOOLTIP"
            [ -f "$UPDATE_FLAG" ] && rm -f "$UPDATE_FLAG"
            rm -f "$REBUILD_FLAG"
          else
            local current_time last_run
            updates=$(cat "$STATE_FILE")
            last_run=$(cat "$LAST_RUN_FILE")
            current_time=$(date +%s)

            if [ $((current_time - last_run)) -gt "$UPDATE_INTERVAL" ]; then
              if [ -f "$UPDATING_FLAG" ]; then
                if check_for_updates; then
                  updates=$(cat "$STATE_FILE"); var_setter
                else
                  updates=""; alt="error"; tooltip=$(cat "$LAST_RUN_TOOLTIP")
                  send_notification "updates-failed" "Update Check Failed" "Check tooltip for detailed error message" -t 3000
                fi
                rm -f "$UPDATING_FLAG"
              else
                updates=$(cat "$STATE_FILE"); alt="updating"; tooltip="Checking for updates"
                : > "$UPDATING_FLAG"
                pkill -x -RTMIN+12 .waybar-wrapped
              fi
            else
              send_notification "updates-wait" "Please Wait" "Next update is in $(calc_next_update) min." -t 2000
              var_setter
            fi
          fi
        else
          updates=$(cat "$STATE_FILE"); var_setter
          send_notification "updates-failed" "Update Check Failed" "Not connected to the internet" -t 3000
        fi

        echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
      }

      main
    '';
  }
