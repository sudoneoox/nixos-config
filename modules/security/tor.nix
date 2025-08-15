{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.X0.security.tor;
in {
  options.X0.security.tor = {
    enable = lib.mkEnableOption "tor";
  };

  config = lib.mkIf cfg.enable {
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
