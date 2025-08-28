{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.system.security.fail2ban {
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
