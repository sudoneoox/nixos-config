{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf config.x0.features.enableQbittorrent {
    environment.systemPackages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
