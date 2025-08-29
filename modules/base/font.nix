# Installs the packages within custom.x0.font
{custom, ...}: let
  x = custom.x0;
in {
  fonts = {
    packages = x.ux.fontPkgs;
    enableDefaultPackages = true;
  };
}
