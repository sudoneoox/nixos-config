{ lib, pkgs }:
import ../values.nix {
  inherit lib pkgs;
  overrides = {};
}
