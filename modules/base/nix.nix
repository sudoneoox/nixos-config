{
  inputs,
  pkgs,
  custom_vars,
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
      allowed-users = ["${custom_vars.USERNAME}"];
      trusted-users = ["${custom_vars.USERNAME}"];
      experimental-features = "nix-command flakes";
      keep-going = true;
      warn-dirty = false;
      http-connections = 50;
    };
  };
}
