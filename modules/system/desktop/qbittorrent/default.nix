{
  pkgs,
  lib,
  custom_vars,
  ...
}: {
  config = lib.mkIf custom_vars.FEATURES.ENABLE_QBITTORRENT {
    environment.systemPackages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
