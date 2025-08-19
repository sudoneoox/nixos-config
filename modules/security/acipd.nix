{
  config,
  lib,
  ...
}: let
  cfg = config.X0.security.acipd;
in {
  options.X0.security.acipd = {
    enable = lib.mkEnableOption "acipd";
  };

  config = lib.mkIf cfg.enable {
    systemd.services.acpid.serviceConfig = {
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      ProtectProc = "invisible";
      PrivateTmp = true;
      PrivateNetwork = true;
      PrivateMounts = true;
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      RestrictAddressFamilies = [
        "~AF_INET6"
        "~AF_INET"
        "~AF_PACKET"
      ];
      MemoryDenyWriteExecute = true;
      LockPersonality = true;
      SystemCallFilter = [
        "~@mount"
        "~@swap"
        "~@obsolete"
        "~@cpu-emulation"
      ];
      SystemCallArchitectures = "native";
      CapabilityBoundingSet = [
        "~CAP_CHOWN"
        "~CAP_FSETID"
        "~CAP_SETFCAP"
      ];
    };
  };
}
