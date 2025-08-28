{config, ...}: let
  x = config.x0;
in {
  programs.nh = {
    enable = true;
    clean = {
      enable = !config.nix.gc.automatic;
      dates = "weekly";
      extraArgs = "--keep 10";
    };

    flake = x.nixosConfPath;
  };
}
