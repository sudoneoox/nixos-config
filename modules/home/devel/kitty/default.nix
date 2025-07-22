{ config, pkgs, ... }:

{
  home.file = {
    ".config/kitty" = {
      source = "${pkgs.skitty}";
      recursive = true;
    };
  };

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
  };
}
