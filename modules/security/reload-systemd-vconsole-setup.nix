{
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf config.x0.system.security.reload-systemd-vconsole-setup {
    systemd.services.reload-systemd-vconsole-setup.serviceConfig = {
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
        "~@obsolete"
        "~@cpu-emulation"
      ];
      SystemCallArchitectures = "native";
    };
  };
}
