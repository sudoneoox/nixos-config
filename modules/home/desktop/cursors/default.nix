{
  pkgs,
  custom_vars,
  ...
}: {
  home.pointerCursor = {
    dotIcons.enable = true;
    hyprcursor.enable = true;
    name = "macOS";
    size = custom_vars.CURSOR_SIZE;
    package = pkgs.apple-cursor;
    gtk.enable = true;
  };
}
