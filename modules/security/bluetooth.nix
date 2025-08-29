# https://github.com/wallago/nix-system-services-hardened/blob/main/services/bluetooth.nix
{
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.system.security.bluetooth {
    systemd.services.bluetooth.serviceConfig = {
      ProtectKernelTunables = lib.mkForce true;
      ProtectKernelModules = lib.mkForce true;
      ProtectKernelLogs = true;
      ProtectHostname = true;
      ProtectControlGroups = true;
      ProtectProc = "invisible";
      SystemCallFilter = [
        "~@obsolete"
        "~@cpu-emulation"
        "~@swap"
        "~@reboot"
        "~@mount"
      ];
      SystemCallArchitectures = "native";
    };
  };
}
