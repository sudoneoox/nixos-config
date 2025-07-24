{ pkgs, ... }:
{
  home.file = {
    ".config/awesome" = {
      recursive = true;
      source = "${pkgs.sawm}";
     };
  };


  home.packages = with pkgs; [
      iosevka
      nerd-fonts.mononoki
      roboto
      fira
  ];
}
