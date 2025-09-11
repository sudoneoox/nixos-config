{
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableKDEConnect {
    programs.kdeconnect.enable = true;
    # Open Ports
    networking.firewall = {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };
  };
}
