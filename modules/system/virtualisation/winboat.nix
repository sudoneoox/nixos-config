{
  custom,
  pkgs,
  lib,
  ...
}: let
  x = custom.x0;
in {
  config =
    lib.mkIf x.features.enableWinboat {
      environment.systemPackages = with pkgs; [winboat];
    };
}
