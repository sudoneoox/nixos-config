{
  inputs,
  pkgs,
  custom,
  ...
}: let
  x = custom.x0;
in {
  nix = {
    optimise.automatic = true;
    package = pkgs.lixPackageSets.git.lix;
    registry.nixpkgs.flake = inputs.nixpkgs;

    gc = {
      automatic = false;
      options = "--delete-older-than 3d";
    };

    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      allowed-users = ["${x.identity.username}"];
      trusted-users = ["${x.identity.username}"];
      experimental-features = "nix-command flakes";
      keep-going = true;
      warn-dirty = false;
      http-connections = 50;
    };
  };
}
