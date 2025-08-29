{
  pkgs,
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableGaming {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
