# Installs the packages within config.x0.font
{
  lib,
  config,
  pkgs,
  ...
}: let
  x = config.x0;
  toPkg = path: lib.getAttrFromPath (lib.splitString "." path) pkgs;
  fontPkgs = builtins.map toPkg x.ux.fontPkgs;
in {
  fonts = {
    packages = fontPkgs;
    enableDefaultPackages = true;
  };
}
