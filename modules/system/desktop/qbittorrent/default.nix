{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.features.enableQbittorrent {
    environment.systemPackages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
