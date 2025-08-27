{
  inputs,
  pkgs,
  X0,
  ...
}: {
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
      allowed-users = ["${X0.USERNAME}"];
      trusted-users = ["${X0.USERNAME}"];
      experimental-features = "nix-command flakes";
      keep-going = true;
      warn-dirty = false;
      http-connections = 50;
    };
  };
}
