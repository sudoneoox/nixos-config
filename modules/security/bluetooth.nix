# https://github.com/wallago/nix-system-services-hardened/blob/main/services/bluetooth.nix
{
  lib,
  custom_vars,
  ...
}: {
  config = lib.mkIf custom_vars.SYSTEM.SECURITY.bluetooth {
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
