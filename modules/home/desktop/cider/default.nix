#NOTE: defined in pkgs/cider-latest.nix
{
  pkgs,
  lib,
  X0,
  ...
}: {
  home.packages = lib.mkIf X0.FEATURES.ENABLE_CIDER [pkgs.ciderLatest];
}
