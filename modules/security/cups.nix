{
  config,
  lib,
  ...
}: let
  cfg = config.X0.security.cups;
in {
  options.X0.security.cups = {
    enable = lib.mkEnableOption "cups";
  };

  config = lib.mkIf cfg.enable {
    systemd.services.cups.serviceConfig = {
      NoNewPrivileges = true;
      ProtectSystem = "full";
      ProtectHome = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      ProtectHostname = true;
      ProtectClock = true;
      ProtectProc = "invisible";
      RestrictRealtime = true;
      RestrictNamespaces = true;
      RestrictSUIDSGID = true;
      RestrictAddressFamilies = [
        "AF_UNIX"
        "AF_NETLINK"
        "AF_INET"
        "AF_INET6"
        "AF_PACKET"
      ];

      MemoryDenyWriteExecute = true;
      SystemCallFilter = [
        "~@clock"
        "~@reboot"
        "~@debug"
        "~@module"
        "~@swap"
        "~@obsolete"
        "~@cpu-emulation"
      ];
      SystemCallArchitectures = "native";
      LockPersonality = true;
    };
  };
}
