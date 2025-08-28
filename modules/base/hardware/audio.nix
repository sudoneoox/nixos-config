{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.x0.features.enableAudio {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    users.users.${config.USERNAME}.extraGroups = ["audio"];
  };
}
