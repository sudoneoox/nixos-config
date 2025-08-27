{
  X0,
  lib,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_BLUETOOTH {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
  #WARN: I personally like to use bluetoothctl so the gui applet I leave disabled
  # services.blueman.enable = X0.FEATURES.ENABLE_BLUETOOTH;
}
