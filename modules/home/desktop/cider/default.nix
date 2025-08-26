#NOTE: defined in pkgs/cider-latest.nix
{
  pkgs,
  lib,
  custom_vars,
  ...
}: {
  home.packages = lib.mkIf custom_vars.FEATURES.ENABLE_CIDER [pkgs.ciderLatest];
}
