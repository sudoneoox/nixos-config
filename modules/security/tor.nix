{
  lib,
  custom_vars,
  pkgs,
  ...
}: {
  config = lib.mkIf custom_vars.SYSTEM.SECURITY.tor {
    services.tor = {
      enable = true;
      enableGeoIP = false;
      openFirewall = true;
      torsocks.enable = true;
      client.enable = true;
      relay.enable = false;
      settings = {
        CookieAuthentication = true;
        AvoidDiskWrites = 1;
        HardwareAccel = 1;
        SafeLogging = 1;
        NumCpus = 3;
      };
    };

    environment.systemPackages = [pkgs.tor-browser];
  };
}
