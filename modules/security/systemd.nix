{
  config,
  lib,
  ...
}: let
  cfg = config.X0.security.systemd;
in {
  options.X0.security.systemd = {
    enable = lib.mkEnableOption "systemd";
  };
  config = lib.mkIf cfg.enable {
    users.groups.netdev = {};
    services = {
      dbus.implementation = "broker";
      logrotate.enable = true;
      journald = {
        # storage = "volatile"; # Store logs in memory
        upload.enable = false; # Disable remote log upload (the default)
        extraConfig = ''
          SystemMaxUse=500M
          SystemMaxFileSize=50M
          MaxFileSec=1month
        '';
      };
    };
  };
}
