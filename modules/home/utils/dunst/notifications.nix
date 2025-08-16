{pkgs, ...}: let
  lowBatteryNotifier = pkgs.writeShellScript "low-battery-notifier" ''
    set -euo pipefail

    #INFO: acpi prints lines like: "Battery 0: Discharging, 14%, 00:20:11 remaining"
    #INFO: If there's no battery (e.g., desktop), just exit quietly.
    if ! ${pkgs.acpi}/bin/acpi -b >/dev/null 2>&1; then
      exit 0
    fi

    BAT_LINE="$(${pkgs.acpi}/bin/acpi -b)"
    BAT_PCT=$(printf '%s\n' "$BAT_LINE" | ${pkgs.gnugrep}/bin/grep -Po '[0-9]+(?=%)' | head -n1 || echo 100)
    BAT_STA=$(printf '%s\n' "$BAT_LINE" | ${pkgs.gnugrep}/bin/grep -Po '\w+(?=,)'   | head -n1 || echo Unknown)

    #INFO: Log to journal for debugging
    echo "$(date) battery status:$BAT_STA percentage:$BAT_PCT"

    if [ "$BAT_STA" = "Discharging" ]; then
      if [ "$BAT_PCT" -le 15 ] && [ "$BAT_PCT" -gt 10 ]; then
        ${pkgs.libnotify}/bin/notify-send -c device -u critical "Low Battery" "Would be wise to keep my charger nearby"
      elif [ "$BAT_PCT" -le 10 ] && [ "$BAT_PCT" -gt 5 ]; then
        ${pkgs.libnotify}/bin/notify-send -c device -u critical "Low Battery" "KEEP ME ALIVE!"
      elif [ "$BAT_PCT" -le 5 ]; then
        ${pkgs.libnotify}/bin/notify-send -c device -u critical "Low Battery" "Charge me or watch me die!"
      fi
    fi
  '';
in {
  #NOTE:: Per-user systemd unit so notifications hit the session bus.
  #NOTE: This defines units for all users; they'll be available when the user session starts.
  systemd.user.services.low-battery-notifier = {
    description = "Low Battery Notifier";
    #INFO: Run only on machines that actually have a battery.
    unitConfig.ConditionPathExistsGlob = "/sys/class/power_supply/BAT*/uevent";
    serviceConfig = {
      Type = "oneshot";
    };
    #WARN: Put required tools in PATH for the service
    path = [pkgs.acpi pkgs.gnugrep pkgs.libnotify pkgs.coreutils];
    #INFO: Just run the script we built above
    script = "${lowBatteryNotifier}";
  };

  systemd.user.timers.low-battery-notifier = {
    description = "Run low-battery-notifier periodically";
    wantedBy = ["timers.target"];
    timerConfig = {
      #INFO: Start a little after login/boot, then repeat every 3 minutes
      OnBootSec = "1min";
      OnUnitActiveSec = "3min";
      Persistent = true; #INFO: catch up after suspend
    };
  };
}
