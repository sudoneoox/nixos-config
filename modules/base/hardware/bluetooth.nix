{
  custom_vars,
  lib,
  ...
}: {
  config = lib.mkIf custom_vars.FEATURES.ENABLE_BLUETOOTH {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
  #WARN: I personally like to use bluetoothctl so the gui applet I leave disabled
  # services.blueman.enable = custom_vars.FEATURES.ENABLE_BLUETOOTH;
}
