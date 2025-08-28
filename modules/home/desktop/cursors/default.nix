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
    size = config.x0.cursorSize;
    package = pkgs.apple-cursor;
    gtk.enable = true;
  };
}
