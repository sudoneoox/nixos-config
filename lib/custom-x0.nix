{
  lib,
  pkgs ? null,
  system ? null,
}: let
  inherit (lib) evalModules;

  mkArgs = _:
    {}
    // (
      if pkgs == null
      then {}
      else {inherit pkgs;}
    )
    // (
      if system == null
      then {}
      else {inherit system;}
    );

  mkX0 = values: let
    eval = evalModules {
      modules = [
        ../modules/x0/schema.nix
        {config.x0 = values;} # only inside this private sandbox
      ];
      specialArgs = mkArgs null; # ← important
    };
  in
    eval.config.x0; # plain attrset (values + derived)
in {
  inherit mkX0;
}
