{
  pkgs,
  custom,
  ...
}: let
  x = custom.x0;
in {
  home.pointerCursor = {
    dotIcons.enable = true;
    hyprcursor.enable = true;
    name = x.ux.cursorTheme;
    size = x.ux.cursorSize;
    package = pkgs.apple-cursor;
    gtk.enable = true;
  };
}
