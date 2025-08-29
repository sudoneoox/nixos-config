{custom, ...}:
# TODO: run script to change wallpaper theme before loading
# https://github.com/arrowpc/palettum
let
  x = custom.x0;
  wallpaperDir = "${x.nixosAssetsPath}/Wallpapers";
  wp = x.ux.wallpaper;
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
