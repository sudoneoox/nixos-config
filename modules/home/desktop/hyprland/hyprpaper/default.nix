{X0, ...}:
# TODO: run script to change wallpaper theme before loading
# https://github.com/arrowpc/palettum
let
  wallpaperDir = "${X0.NIXOS_ASSETS_PATH}/Wallpapers";
  wp = X0.WALLPAPER;
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
