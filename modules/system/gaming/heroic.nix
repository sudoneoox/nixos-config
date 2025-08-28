{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableGaming {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
