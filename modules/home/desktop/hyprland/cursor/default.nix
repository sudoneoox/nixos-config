{ pkgs, ... }:
{
  home.pointerCursor = {
    name = "macOS";
    size = 24;
    package = pkgs.apple-cursor;
    gtk.enable = true;

  };
}
