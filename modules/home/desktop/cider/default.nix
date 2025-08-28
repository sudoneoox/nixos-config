#NOTE: defined in pkgs/cider-latest.nix
{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
  ciderLatest = pkgs.callPackage ../../../../pkgs/applications/cider-latest.nix {
    username = x.identity.username;
  };
in {
  config = lib.mkIf x.features.enableCider {
    home.packages = [ciderLatest];
  };
}
