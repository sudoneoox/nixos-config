{pkgs, ...}: {
  home.packages = with pkgs; [
    chafa
    jq
    procps
    libnotify
  ];

  home.file = {
    "Assets/nixos-config/wallust/templates" = {
      source = ./templates;
      recursive = true;
    };
    "Assets/scripts" = {
      source = ./scripts;
      recursive = true;
    };
    ".config/wallust/config.toml".source = ./config.toml;
  };

  programs.wallust.enable = true;
}
