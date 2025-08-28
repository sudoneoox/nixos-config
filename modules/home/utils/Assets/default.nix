{
  # WARN: not matched up with config.x0.nixosAssetsPath
  # TODO: find a way to match to whats defined in modules/x0/values.nix
  home.file = {
    "Assets/nixos-config/Icons" = {
      source = ./icons;
      recursive = true;
    };
    "Assets/nixos-config/Wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };
}
