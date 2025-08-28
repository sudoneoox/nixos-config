{
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf config.x0.system.security.systemd {
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
