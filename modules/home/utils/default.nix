{
  config,
  lib,
  ...
}: {
  imports =
    [
      ./Assets
      ./rofi
      ./dunst
    ]
    ++ lib.optionals config.x0.features.enableUdiskie [./udiskie]
    ++ lib.optionals (config.COLOR_SCHEME == "wallust") [./wallust];
}
