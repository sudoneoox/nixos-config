{
  pkgs,
  username,
  lib,
  host,
  ...
}:
{

  imports = [
    # TODO: Currently not using and don't have the time to learn
    # ../../quickshell
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "${username}";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    package = pkgs.hyprland-git.hyprland;
    portalPackage = pkgs.hyprland-git.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisble
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint electron apps to use wauland
    NIXOS_OZONE_WL = "1";

    # For Hyprland QT Support
    QML_IMPORT_PATH = "${pkgs.hyprland-qt-support}/lib/qt-6/qml";
  };

  environment.systemPackages =
    with pkgs;
    [
      dunst
      rofi-wayland
      hyprpaper
      hyprlock
      hyprpicker
      hyprshade
      copyq

    ]
    ++ lib.optionals (host == "X0NixOSDesktop") [
      # In overlays/default.nix
      hyprland-smw
    ];

  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
  };

}
