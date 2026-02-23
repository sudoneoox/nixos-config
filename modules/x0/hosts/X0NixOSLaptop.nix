{
  lib,
  pkgs,
}:
import ../values.nix {
  inherit lib pkgs;
  overrides = {
    identity = {
      OS = "nix";
    };
    system = {
      hostProfile = "laptop";
    };
  };
}
