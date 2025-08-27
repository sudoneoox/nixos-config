{
  custom_vars,
  lib,
  ...
}: {
  config = lib.mkIf custom_vars.FEATURES.ENABLE_AUDIO {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    users.users.${custom_vars.USERNAME}.extraGroups = ["audio"];
  };
}
