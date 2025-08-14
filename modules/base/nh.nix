{
  config,
  username,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = !config.nix.gc.automatic;
      dates = "weekly";
      extraArgs = "--keep 10";
    };

    flake = "/home/${username}/Projects/nixos-config";
  };
}
