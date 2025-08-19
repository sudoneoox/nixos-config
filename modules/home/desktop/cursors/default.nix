{
  pkgs,
  custom_vars,
  ...
}: {
  home.pointerCursor = {
    name = "macOS";
    size = custom_vars.CURSOR_SIZE;
    package = pkgs.apple-cursor;
    gtk.enable = true;
  };
}
