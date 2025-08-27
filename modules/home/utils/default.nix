{
  X0,
  lib,
  ...
}: {
  imports =
    [
      ./Assets
      ./rofi
      ./dunst
    ]
    ++ lib.optionals X0.FEATURES.ENABLE_UDISKIE [./udiskie]
    ++ lib.optionals (X0.COLOR_SCHEME == "wallust") [./wallust];
}
