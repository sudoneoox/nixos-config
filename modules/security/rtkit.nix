{
  config,
  lib,
  ...
}: let
  cfg = config.X0.security.rtkit;
in {
  options.X0.security.rtkit = {
    enable = lib.mkEnableOption "rtkit";
  };
  config =
    lib.mkIf cfg.enable
    {
      security.rtkit.enable = true;
      systemd.services.rtkit-daemon.serviceConfig = {
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectClock = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        PrivateTmp = true;
        PrivateMounts = true;
        PrivateDevices = true;
        RestrictNamespaces = true;
        RestrictSUIDSGID = true;
        RestrictAddressFamilies = [
          "~AF_INET6"
          "~AF_INET"
          "~AF_PACKET"
        ];
        MemoryDenyWriteExecute = true;
        DevicePolicy = "closed";
        LockPersonality = true;
        SystemCallFilter = [
          "~@keyring"
          "~@swap"
          "~@clock"
          "~@module"
          "~@obsolete"
          "~@cpu-emulation"
        ];
      };
    };
}
