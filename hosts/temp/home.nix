{ pkgs, username, ... }:
{

  imports = [
    ../../modules/home/desktop/awesome
    ../../modules/home/desktop/hyprland
  ];



  gtk.enable = true;

  qt.enable = true;

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override { enableWlrSupport = true; };
  };

  home.packages = with pkgs; [
    proton-pass
    tor-browser
  ];

  home.stateVersion = "25.05";
}
