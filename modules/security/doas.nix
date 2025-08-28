{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.system.security.doas {
    # Disable sudo
    # I had issues with disabling this you might have better luck
    security.sudo.enable = true;

    # enable and configure doas
    security.doas = {
      enable = true;
      extraRules = [
        {
          # Grant doas access specifically to your user
          users = ["${config.USERNAME}"];
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
