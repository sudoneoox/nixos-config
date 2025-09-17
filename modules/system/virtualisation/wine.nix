{
  pkgs,
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableWine {
    environment.systemPackages = with pkgs; [
      wineWowPackages.staging
      winetricks
      bottles-unwrapped
    ];
  };
}
