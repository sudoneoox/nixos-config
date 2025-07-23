{inputs, pkgs, username, ...}:
{
  nix = {
    package = pkgs.lix;

    registry.nixpkgs.flake = inputs.nixpkgs;

    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };

    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      allowed-users = [ "${username}" ];
      trusted-users = [ "${username}" ];
      experimental-features = "nix-command flakes";
      keep-going = true;
      warn-dirty = false;
      http-connections = 50;
    };
  };
}
