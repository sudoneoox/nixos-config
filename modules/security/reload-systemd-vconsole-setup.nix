{
  config,
  lib,
  ...
}: let
  cfg = config.X0.security.reload-systemd-vconsole-setup;
in {
  options.X0.security.reload-systemd-vconsole-setup = {
    enable = lib.mkEnableOption "reload-systemd-vconsole-setup";
  };

  config = lib.mkIf cfg.enable {
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
