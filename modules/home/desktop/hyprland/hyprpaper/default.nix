{
  lib,
  username,
  ...
}:

# TODO: run script to change wallpaper theme before loading
# https://github.com/arrowpc/palettum
let
  relativeWallpaperDir = "Assets/nixos-config/Wallpapers";
  fullWallpaperDir = "/home/${username}/${relativeWallpaperDir}";

  wp = "wallpaper4_smoothed_catppuccin.png";
in
{

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = "${fullWallpaperDir}/${wp}";
      wallpaper = ",${fullWallpaperDir}/${wp}";
    };
  };
}
