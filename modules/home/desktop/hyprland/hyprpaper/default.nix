{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "./wallpapers/wallpaper4_smoothed_catppuccin.png"
      ];
      wallpaper = [
        "./wallpapers/wallpaper4_smoothed_catppuccin.png"
      ];
    };
  };
}
