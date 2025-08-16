{pkgs, ...}: {
  #NOTE:: Per-user systemd unit so notifications hit the session bus.
  #NOTE: This defines units for all users; they'll be available when the user session starts.

  systemd.user.services.low-battery-notifier = {
    description = "Low Battery Notifier";
    unitConfig = {
      #INFO: Only start on machines that actually have a battery.
      ConditionPathExistsGlob = "/sys/class/power_supply/BAT*/uevent";
    };
    serviceConfig.Type = "oneshot";
    script = "${pkgs.lowBatteryNotifier}/bin/low-battery-notifier";
    wantedBy = ["default.target"];
  };

  systemd.user.timers.low-battery-notifier = {
    description = "Run low-battery-notifier periodically";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "3min";
      Persistent = true;
    };
    wantedBy = ["timers.target"];
  };
}
