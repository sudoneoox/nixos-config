{host, lib, ...}:
{

  imports = [
    ./cursor
    ./waybar
    ./hyprlock
    ./hyprpaper
    ./hyprshade
    ./dunst
    ./wallust
    ../rofi
  ] 
    ++ lib.optional (host == "X0NixOSLaptop") ./single-monitor.nix
    ++ lib.optional (host == "X0NixOSDesktop") ./multi-monitor.nix;

  home.file."Assets/nixos-config/scripts".source = ./scripts;
  home.file."Assets/nixos-config/scripts".recursive = true;
  home.file."Assets/nixos-config/shaders".source = ./hyprshade/shaders;
  home.file."Assets/nixos-config/shaders".recursive = true;
  home.file."Assets/nixos-config/shaders/hyprshade.toml".source = ./hyprshade/hyprshade.toml;
  home.file."Assets/nixos-config/hyprlock/face.jpg".source = ./hyprlock/face.jpg;
  home.file."Assets/nixos-config/Icons/dunst".source = ./dunst/icons;
  home.file."Assets/nixos-config/Icons/dunst".recursive = true;
  home.file."Assets/nixos-config/Wallpapers".source = ./hyprpaper/wallpapers;
  home.file."Assets/nixos-config/Wallpapers".recursive = true;
  home.file."Assets/nixos-config/wallust/wallust.toml".source ./wallust/wallust.toml;

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  services.network-manager-applet.enable = true;

  xdg.autostart.enable = true;

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.variables = [ "--all" ];
  };

}
