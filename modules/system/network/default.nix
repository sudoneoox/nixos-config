{
  host,
  pkgs,
  config,
  ...
}: {
  networking = {
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [config.sops.secrets."wireless.env".path];
        profiles = {
          HomeWiFi = {
            connection = {
              id = "HomeWiFi";
              type = "wifi";
            };

            wifi = {
              ssid = "$HOME_WIFI_SSID";
            };

            wifi-security = {
              key-mgmt = "wpa-psk";
              auth-alg = "open";
              psk = "$HOME_WIFI_PASSWORD";
            };
          };
        };
      };
    };
    hostName = host;
    nameservers = [
      # Cloudflare Security Focus DNS Name Servers
      "1.1.1.2"
      "1.0.0.2"
    ];
    firewall.enable = true;
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
