{ pkgs
, username
, ...
}:
{
  nix = {
    package = pkgs.lix;

    gc = {
      automatic = true;
      options = "--keep-generations 6";
    };

    # channel.enable = false;
    channel.enable = true;

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
