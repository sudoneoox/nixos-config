{config, ...}:
# TODO: run script to change wallpaper theme before loading
# https://github.com/arrowpc/palettum
let
  x = config.x0;
  wallpaperDir = "${x.nixosAssetsPath}/Wallpapers";
  wp = x.wallpaper;
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
