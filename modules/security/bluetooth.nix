# https://github.com/wallago/nix-system-services-hardened/blob/main/services/bluetooth.nix
{
  lib,
  config,
  ...
}: let
  cfg = config.X0.security.bluetooth;
in {
  options.X0.security.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf cfg.enable {
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
