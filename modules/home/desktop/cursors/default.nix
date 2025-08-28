{
  pkgs,
  config,
  ...
}: let
  x = config.x0;
in {
  home.pointerCursor = {
    dotIcons.enable = true;
    hyprcursor.enable = true;
    name = "macOS";
    size = x.cursorSize;
    package = pkgs.apple-cursor;
    gtk.enable = true;
  };
}
