{custom_vars, ...}: {
  hardware.bluetooth = {
    enable = custom_vars.FEATURES.ENABLE_BLUETOOTH;
    powerOnBoot = custom_vars.FEATURES.ENABLE_BLUETOOTH;
    settings.General.Experimental = custom_vars.FEATURES.ENABLE_BLUETOOTH;
  };
  # I personally like to use bluetoothctl so the gui applet i leave disabled
  # services.blueman.enable = custom_vars.FEATURES.ENABLE_BLUETOOTH;
}
