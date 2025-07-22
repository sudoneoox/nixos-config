{ config, pkgs, ... }:

{
  home.file = {
    ".config/kitty" = {
      source = "${pkgs.skitty}";
      recursive = true;
    };
  };
}
