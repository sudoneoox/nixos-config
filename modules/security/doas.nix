{
  lib,
  config,
  custom_vars,
  ...
}: let
  cfg = config.X0.security.doas;
in {
  # https://search.nixos.org/options?channel=unstable&show=security.doas.extraRules.*.persist&from=0&size=50&sort=relevance&type=packages&query=security.doas
  options.X0.security.doas = {
    enable = lib.mkEnableOption "doas";
  };

  config = lib.mkIf cfg.enable {
    # Disable sudo
    # I had issues with disabling this you might have better luck
    security.sudo.enable = true;

    # enable and configure doas
    security.doas = {
      enable = true;
      extraRules = [
        {
          # Grant doas access specifically to your user
          users = ["${custom_vars.USERNAME}"];
          # Convenient but less secure 'if true' do not ask for a password again for some time after th euser succesfully authenticates

          persist = true;
          # noPass = true  # Convenient but even less secure
          keepEnv = true; # often necessary
          # Optional; you can also specify which commands they can run, e.g.:
          # cmd = "ALL"; # allows running all commands (default if not specified)
          # cmd = "/run/current-system/sw/bin/nixos-rebuild; # Only allow specific commands
        }
      ];
    };

    # Only enable this if doas works as a standalone replacement for sudo for you
    # environment.shellAliases = {
    #   sudo = "doas";
    # };
  };
}
