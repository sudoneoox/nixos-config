{custom_vars, ...}:
# TODO: run script to change wallpaper theme before loading
# https://github.com/arrowpc/palettum
let
  wallpaperDir = "${custom_vars.NIXOS_ASSETS_PATH}/Wallpapers";
  wp = "nixos.png";
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
