{ pkgs, username, ... }:
{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "${username}";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland-git.hyprland;
    portalPackage = pkgs.hyprland-git.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisble
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint electron apps to use wauland
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    dunst
    rofi-wayland
    quickshell
    hyprpaper
    copyq
  ];

  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
  };
}
