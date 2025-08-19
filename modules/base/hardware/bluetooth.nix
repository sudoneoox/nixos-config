{custom_vars, ...}: {
  hardware.bluetooth = {
    enable = custom_vars.ENABLE_BLUETOOTH;
    powerOnBoot = custom_vars.ENABLE_BLUETOOTH;
    settings.General.Experimental = custom_vars.ENABLE_BLUETOOTH;
  };
  services.blueman.enable = custom_vars.ENABLE_BLUETOOTH;
}
