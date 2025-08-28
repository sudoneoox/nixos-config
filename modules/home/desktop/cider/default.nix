#NOTE: defined in pkgs/cider-latest.nix
{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  home.packages = lib.mkIf config.x0.features.enableCider [pkgs.ciderLatest];
}
