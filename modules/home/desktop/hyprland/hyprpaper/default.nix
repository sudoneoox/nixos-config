{
  lib,
  username,
  ...
}:

# TODO: run script to change wallpaper theme before loading
# https://www.reddit.com/r/unixporn/comments/1m7a001/oc_yet_another_media_recoloring_tool_worth_it/

let
  srcWallpapersDir = ./wallpapers;
  wallpaperFiles = builtins.attrNames (builtins.readDir srcWallpapersDir);

  relativeWallpaperDir = "Pictures/Wallpapers";
  fullWallpaperDir = "/home/${username}/${relativeWallpaperDir}";

  wp = "wallpaper4_smoothed_catppuccin.png";

  wallpaperMappings = lib.genAttrs wallpaperFiles (name: {
    source = "${srcWallpapersDir}/${name}";
    target = "${fullWallpaperDir}/${name}";
  });

in
{
  home.file = wallpaperMappings;

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = "${fullWallpaperDir}/${wp}";
      wallpaper = ",${fullWallpaperDir}/${wp}";
    };
  };
}
