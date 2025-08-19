{
  config,
  lib,
  ...
}: let
  cfg = config.X0.security.systemd-ask-password-console;
in {
  options.X0.security.systemd-ask-password-console = {
    enable = lib.mkEnableOption "systemd-ask-password-console";
  };

  config = lib.mkIf cfg.enable {
    systemd.services.systemd-ask-password-console.serviceConfig = {
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ProtectClock = true;
      ProtectHostname = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectProc = "invisible";
      PrivateTmp = true;
      PrivateMounts = true;
      PrivateNetwork = true;
      PrivateDevices = true;
      RestrictNamespaces = true;
      RestrictRealtime = true;
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
