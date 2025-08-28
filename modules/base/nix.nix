{
  inputs,
  pkgs,
  config,
  ...
}: let
  x = config.x0;
in {
  nix = {
    optimise.automatic = true;
    package = pkgs.lixPackageSets.latest.lix;
    registry.nixpkgs.flake = inputs.nixpkgs;

    gc = {
      automatic = false;
      options = "--delete-older-than 3d";
    };

    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      allowed-users = ["${config.x0.username}"];
      trusted-users = ["${config.x0.username}"];
      experimental-features = "nix-command flakes";
      keep-going = true;
      warn-dirty = false;
      http-connections = 50;
    };
  };
}
