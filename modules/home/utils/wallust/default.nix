{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf (x.ux.colorScheme == "wallust") {
    xdg.configFile = {
      "wallust/templates" = {
        source = ./templates;
        recursive = true;
      };

      "wallust/wallust.toml".source = ./wallust.toml;
    };

    programs.wallust.enable = true;
  };
}
