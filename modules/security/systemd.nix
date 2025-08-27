{
  lib,
  custom_vars,
  ...
}: {
  config = lib.mkIf custom_vars.SYSTEM.SECURITY.systemd {
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
