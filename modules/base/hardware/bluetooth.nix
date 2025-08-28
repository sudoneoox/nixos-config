{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableBluetooth {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
  #WARN: I personally like to use bluetoothctl so the gui applet I leave disabled
  # services.blueman.enable = x.features.enableBluetooth;
}
