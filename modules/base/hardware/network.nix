{
  host,
  pkgs,
  config,
  config,
  ...
}: let
  x = config.x0;
in {
  networking = {
    networkmanager = {
      enable = true;

      # Pull secrets (SSID/passwords/usernames) from sops
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
              mode = "infrastructure";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              auth-alg = "open";
              psk = "$HOME_WIFI_PASSWORD";
            };
            ipv4.method = "auto";
            ipv6.method = "auto";
          };

          eduroam = {
            connection = {
              id = "eduroam";
              type = "wifi";
            };
            wifi = {
              ssid = "eduroam";
              mode = "infrastructure";
            };
            wifi-security = {
              key-mgmt = "wpa-eap"; # WPA/WPA2 Enterprise
            };
            "802-1x" = {
              eap = "peap"; # EAP(PEAP)
              identity = "$EDUROAM_IDENTITY"; # e.g., yourid@uh.edu
              anonymous-identity = "anon";
              password = "$EDUROAM_PASSWORD";
              phase2-auth = "mschapv2"; # Inner auth

              # PEAP version: automatic (0 -> auto in wpa_supplicant)
              phase1-peapver = 0;

              # No CA certificate
              system-ca-certs = false;
              ca-cert = "";

              # Require the RADIUS server’s cert CN/SAN to end with uh.edu
              # domain-suffix-match = "uh.edu";
              domain-suffix-match = "$EDUROAM_DOMAIN";
            };
            ipv4.method = "auto";
            ipv6.method = "auto";
          };

          school-secure = {
            connection = {
              id = "school-secure";
              type = "wifi";
            };
            wifi = {
              ssid = "$SCHOOL_NETWORK_SSID";
              mode = "infrastructure";
            };
            wifi-security = {
              key-mgmt = "wpa-eap"; # WPA/WPA2 Enterprise
            };
            "802-1x" = {
              eap = "peap"; # EAP(PEAP)
              identity = "$EDUROAM_IDENTITY"; # e.g., yourid@uh.edu
              anonymous-identity = "anon";
              password = "$SCHOOL_NETWORK_PASSWORD"; # e.g., yourid@uh.edu
              phase2-auth = "mschapv2"; # Inner auth

              # PEAP version: automatic (0 -> auto in wpa_supplicant)
              phase1-peapver = 0;

              # No CA certificate
              system-ca-certs = false;
              ca-cert = "";

              # Require the RADIUS server’s cert CN/SAN to end with uh.edu
              # domain-suffix-match = "uh.edu";
              domain-suffix-match = "$SCHOOL_NETWORK_DOMAIN";
            };
            ipv4.method = "auto";
            ipv6.method = "auto";
          };
        };
      };
    };

    hostName = host;
    nameservers = [
      "1.1.1.2"
      "1.0.0.2"
    ];
    firewall.enable = true;
  };

  users.users.${config.x0.username}.extraGroups = ["networkmanager"];

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
