{
  X0,
  lib,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_AUDIO {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    users.users.${X0.USERNAME}.extraGroups = ["audio"];
  };
}
