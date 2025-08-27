{
  custom_vars,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf custom_vars.FEATURES.ENABLE_PRINTING {
    users.users.${custom_vars.USERNAME}.extraGroups = ["scanner" "lp"];

    environment.systemPackages = with pkgs; [
      gscan2pdf
      brscan5
    ];

    hardware.sane = {
      enable = true;
      extraBackends = with pkgs; [sane-airscan];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.printing = {
      enable = true;
      openFirewall = true;
      logLevel = "info";
      drivers = with pkgs; [cups-filters cups-browsed];

      browsed.enable = true;

      webInterface = true;
    };

    hardware.printers.ensurePrinters = [
      # Use IPP Everywhere. Prefer IP (stable) or mDNS name if your network’s solid.
      {
        name = "Brother-J805DW";
        # EITHER stable IP:
        deviceUri = "ipp://192.168.1.253/ipp/print";
        # OR mDNS (comment the other one out):
        # deviceUri = "ipp://BRW485F99CA99E6.local/ipp/print";

        # If your printer also supports TLS, you can use ipps:// .../ipp/print instead.
        model = "everywhere";
        location = "Home";
        description = "Brother MFC-J805DW (IPP Everywhere)";
      }
    ];
  };
}
