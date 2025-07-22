{ pkgs, ... }:
{
  home.file = {
    ".config/awesome" = {
      source = pkgs.sawm;
      recursive = true;
    };
  };
}
