{
  programs.hyprlock.enable = true;
  xdg.configFile."hyprlock/colors.conf".source = ./colors.conf;
  imports = [
    ./hyprlock-conf.nix
  ];
}
