{
  pkgs,
  lib,
  custom,
  ...
}:
pkgs.writeShellApplication lib.mkIf custom.x0.derived.isLaptop {
  name = "low-battery-notifier";
  runtimeInputs = [
    pkgs.acpi
    pkgs.gnugrep
    pkgs.libnotify
    pkgs.coreutils
  ];
  text = ''
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
}
