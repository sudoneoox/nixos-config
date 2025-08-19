{custom_vars, ...}: {
  services.pipewire = {
    enable = custom_vars.ENABLE_AUDIO;
    alsa.enable = custom_vars.ENABLE_AUDIO;
    alsa.support32Bit = custom_vars.ENABLE_AUDIO;
    pulse.enable = custom_vars.ENABLE_AUDIO;
    wireplumber.enable = custom_vars.ENABLE_AUDIO;
  };
}
