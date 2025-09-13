{
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.system.security.adguardHome {
    services.adguardhome = {
      enable = true;
      mutableSettings = false;
      settings = {
        http = {address = "127.0.0.1:3003";};
        querylog = {
          enabled = true;
          file_enabled = true;
          interval = "720h"; # was "30d" -> INVALID
        };
        statistics = {
          enabled = true;
          interval = "720h"; # was "30d" -> INVALID
        };

        dns = {
          bind_host = "127.0.0.1";
          port = 53;

          # Plain DNS upstreams (no #hostname suffix)
          upstream_dns = [
            "9.9.9.9"
            "149.112.112.112"
          ];

          # If you later switch to DoH, add bootstrap + DoH URLs, e.g.:
          # upstream_dns = [
          #   "https://dns.quad9.net/dns-query"
          # ];
          # bootstrap_dns = [ "1.1.1.1" "9.9.9.10" "8.8.8.8" ];

          enable_dnssec = true;
        };

        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
          parental_enabled = false;
          safe_search = {enabled = false;};
        };

        # Write filters out explicitly (avoid map until we’re up)
        filters = [
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt";
          }
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt";
          }
        ];
      };
    };
  };
}
