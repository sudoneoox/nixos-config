{
  lib,
  custom_vars,
  pkgs,
  ...
}: let
  toPkg = path: lib.getAttrFromPath (lib.splitString "." path) pkgs;
  fontPkgs = builtins.map toPkg custom_vars.FONT_PKGS;
in {
  fonts = {
    packages = fontPkgs;
    enableDefaultPackages = true;
  };
}
