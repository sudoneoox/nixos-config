{
  custom_vars,
  lib,
  ...
}: {
  imports =
    [
      ./Assets
      ./rofi
      ./dunst
    ]
    ++ lib.optionals custom_vars.ENABLE_UDISKIE [./udiskie]
    ++ lib.optionals (custom_vars.COLOR_SCHEME == "wallust") [./wallust];
}
