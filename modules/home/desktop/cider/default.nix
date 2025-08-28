#NOTE: defined in pkgs/cider-latest.nix
{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = lib.mkIf config.x0.features.enableCider [pkgs.ciderLatest];
}
