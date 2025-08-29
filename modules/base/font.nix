# Installs the packages within custom.x0.font
{
  lib,
  custom,
  pkgs,
  ...
}: let
  x = custom.x0;
  toPkg = path: lib.getAttrFromPath (lib.splitString "." path) pkgs;
  fontPkgs = builtins.map toPkg x.ux.fontPkgs;
in {
  fonts = {
    packages = fontPkgs;
    enableDefaultPackages = true;
  };
}
