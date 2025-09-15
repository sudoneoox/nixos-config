{
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableBluetooth {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
    services.blueman.enable = x.features.enableBluetooth;
  };
}
