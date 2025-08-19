{
  custom_vars,
  lib,
  ...
}: {
  imports =
    [
      ./Assets
      ./wallust
      ./rofi
      ./dunst
    ]
    ++ lib.optionals custom_vars.ENABLE_UDISKIE [./udiskie];
}
