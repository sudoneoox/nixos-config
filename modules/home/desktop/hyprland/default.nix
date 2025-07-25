{ pkgs, ... }:
{

  home.file = {
    ".config/hypr" = {
      source = "${pkgs.shypr}";
      recursive = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.variables = [ "--all" ];
  };

}

 
