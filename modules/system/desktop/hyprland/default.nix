{
  pkgs,
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "${x.identity.username}";
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

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };

  environment.systemPackages = with pkgs;
    [
      wl-gammarelay-rs
      dunst
      rofi-wayland
      hyprpaper
      hyprlock
      hyprpicker
      hyprshade
      copyq
    ]
    ++ lib.optionals (x.derived.monitorsEff == "multi") [
      # In overlays/default.nix
      hyprland-smw
    ];

  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    # If your cursor becomes invisble

    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wauland
    NIXOS_OZONE_WL = "1";
    # For Hyprland QT Support
    QML_IMPORT_PATH = "${pkgs.hyprland-qt-support}/lib/qt-6/qml";

    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}
