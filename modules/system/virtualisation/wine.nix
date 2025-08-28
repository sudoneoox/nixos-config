{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableWine {
    environment.systemPackages = with pkgs; [
      wineWowPackages.staging
      winetricks
    ];

    services.flatpak.enable = true;
  };
}
