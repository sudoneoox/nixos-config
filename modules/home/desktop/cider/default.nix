#NOTE: defined in pkgs/cider-latest.nix
{
  lib,
  custom,
  pkgs,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableCider {
    home.packages = with pkgs; [ciderLatest];
  };
}
