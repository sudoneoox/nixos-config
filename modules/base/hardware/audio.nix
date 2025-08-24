{custom_vars, ...}: {
  services.pipewire = {
    enable = custom_vars.FEATURES.ENABLE_AUDIO;
    alsa.enable = custom_vars.FEATURES.ENABLE_AUDIO;
    alsa.support32Bit = custom_vars.FEATURES.ENABLE_AUDIO;
    pulse.enable = custom_vars.FEATURES.ENABLE_AUDIO;
    wireplumber.enable = custom_vars.FEATURES.ENABLE_AUDIO;
  };
  users.users.${custom_vars.USERNAME}.extraGroups = ["audio"];
}
