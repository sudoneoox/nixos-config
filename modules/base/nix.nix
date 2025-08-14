{
  inputs,
  pkgs,
  username,
  ...
}: {
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    registry.nixpkgs.flake = inputs.nixpkgs;

    gc = {
      automatic = false;
      options = "--delete-older-than 3d";
    };

    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      allowed-users = ["${username}"];
      trusted-users = ["${username}"];
      experimental-features = "nix-command flakes";
      keep-going = true;
      warn-dirty = false;
      http-connections = 50;
    };
  };
}
