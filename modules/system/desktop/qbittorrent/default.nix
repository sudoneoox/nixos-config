{
  pkgs,
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableQbittorrent {
    environment.systemPackages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
