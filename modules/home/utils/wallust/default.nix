{
  xdg.configFile = {
    "wallust/templates" = {
      source = ./templates;
      recursive = true;
    };

    "wallust/wallust.toml".source = ./wallust.toml;
  };

  programs.wallust.enable = true;
}
