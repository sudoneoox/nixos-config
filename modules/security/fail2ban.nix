{
  config,
  lib,
  ...
}: let
  cfg = config.X0.security.fail2ban;
in {
  options.X0.security.fail2ban = {
    enable = lib.mkEnableOption "fail2ban";
  };

  config = lib.mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "1h";
      # ignoreIP = [
      #
      # ];

      bantime-increment = {
        enable = true; # Enable increment of bantime after each violation
        multipliers = "1 2 4 8 16 32 64 128 256";
        maxtime = "168h"; # Do not ban for more than 1 week
        overalljails = true; # Calculate the bantime based on all the violations
      };
    };
  };
}
