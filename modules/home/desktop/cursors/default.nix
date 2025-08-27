{
  pkgs,
  X0,
  ...
}: {
  home.pointerCursor = {
    dotIcons.enable = true;
    hyprcursor.enable = true;
    name = "macOS";
    size = X0.CURSOR_SIZE;
    package = pkgs.apple-cursor;
    gtk.enable = true;
  };
}
