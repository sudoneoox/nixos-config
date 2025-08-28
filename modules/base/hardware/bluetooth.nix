{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.x0.features.enableBluetooth {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
  #WARN: I personally like to use bluetoothctl so the gui applet I leave disabled
  # services.blueman.enable = config.x0.features.enableBluetooth;
}
