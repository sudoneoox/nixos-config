{
  pkgs,
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  systemd.user.services.wallust-apply-current = lib.mkIf (x.ux.colorScheme
    == "wallust") {
    enable = true;
    description = "Run Wallust once on session start using current wallpaper";
    wantedBy = ["default.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "oneshot";
      # Ensure notify-send can reach the bus even early in session
      Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus";
    };
    script = "${pkgs.wallustApplyCurrent}/bin/wallust-apply-current";
  };
}
