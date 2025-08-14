{
  home.file = {
    "Assets/nixos-config/scripts" = {
      source = ./scripts;
      recursive = true;
    };

    "Assets/nixos-config/shaders" = {
      source = ./shaders;
      recursive = true;
    };
    "Assets/nixos-config/shaders/hyprshade.toml" = {
      source = ../../desktop/hyprland/hyprshade/hyprshade.toml;
    };
    "Assets/nixos-config/hyprlock/face.jpg" = {
      source = ./hyprlock/face.jpg;
    };
    "Assets/nixos-config/Icons/dunst" = {
      source = ./icons;
      recursive = true;
    };
    "Assets/nixos-config/Wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };
}
