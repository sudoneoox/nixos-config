{
  pkgs,
  lib,
  X0,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_QBITTORRENT {
    environment.systemPackages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
