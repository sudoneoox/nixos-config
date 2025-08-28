# Installs the packages within config.x0.font
{
  lib,
  config,
  pkgs,
  ...
}: let
  toPkg = path: lib.getAttrFromPath (lib.splitString "." path) pkgs;
  fontPkgs = builtins.map toPkg config.x0.fontPkgs;
in {
  fonts = {
    packages = fontPkgs;
    enableDefaultPackages = true;
  };
}
