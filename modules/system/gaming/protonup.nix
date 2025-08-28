{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.features.enableGaming {
    environment.systemPackages = with pkgs; [
      protonup
    ];

    environment.variables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
