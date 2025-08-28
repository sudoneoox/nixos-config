{config, ...}:
# TODO: run script to change wallpaper theme before loading
# https://github.com/arrowpc/palettum
let
  wallpaperDir = "${config.x0.nixosAssetsPath}/Wallpapers";
  wp = config.x0.wallpaper;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = "${wallpaperDir}/${wp}";
      wallpaper = ",${wallpaperDir}/${wp}";
    };
  };
}
