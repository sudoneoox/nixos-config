{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.features.enableGaming {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
