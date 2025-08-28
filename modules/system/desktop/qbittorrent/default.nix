{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableQbittorrent {
    environment.systemPackages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
