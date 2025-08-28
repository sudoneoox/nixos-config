{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  imports =
    [
      ./Assets
      ./rofi
      ./dunst
    ]
    ++ lib.optionals x.features.enableUdiskie [./udiskie]
    ++ lib.optionals (config.COLOR_SCHEME == "wallust") [./wallust];
}
