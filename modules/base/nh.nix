{
  config,
  X0,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = !config.nix.gc.automatic;
      dates = "weekly";
      extraArgs = "--keep 10";
    };

    flake = X0.NIXOS_CONF_PATH;
  };
}
