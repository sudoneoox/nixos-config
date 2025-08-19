{
  config,
  custom_vars,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = !config.nix.gc.automatic;
      dates = "weekly";
      extraArgs = "--keep 10";
    };

    flake = custom_vars.NIXOS_CONF_PATH;
  };
}
