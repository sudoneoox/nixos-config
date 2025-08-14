{pkgs, ...}: {
  home.packages = with pkgs; [
    grc # fzf needs this?
    chafa # for wallpaper preview
    procps
    libnotify # to send notifications
  ];

  home.file = {
    ".config/wallust/templates" = {
      source = ./templates;
      recursive = true;
    };
    "Assets/scripts" = {
      source = ./scripts;
      recursive = true;
    };
    ".config/wallust/wallust.toml".source = ./wallust.toml;
  };

  programs.wallust.enable = true;
}
