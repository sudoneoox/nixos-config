#NOTE: defined in pkgs/cider-latest.nix
{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  home.packages = lib.mkIf x.features.enableCider [pkgs.ciderLatest];
}
