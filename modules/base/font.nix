# Installs the packages within X0.FONT
{
  lib,
  X0,
  pkgs,
  ...
}: let
  toPkg = path: lib.getAttrFromPath (lib.splitString "." path) pkgs;
  fontPkgs = builtins.map toPkg X0.FONT_PKGS;
in {
  fonts = {
    packages = fontPkgs;
    enableDefaultPackages = true;
  };
}
