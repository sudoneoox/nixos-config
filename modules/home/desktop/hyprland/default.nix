{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.variables = [ "--all" ];

    settings =
      let
        terminal = "kitty";
        floating_terminal = "kitty --class=com.kitty.floating";
        editor = "kitty -e nvim";
        browser = "firefox";
        filemanager = "thunar";
      in
      { };
  };

}

 
