#TODO: FINISH PERSIST SETUP
#WARN: Not Ready or tested
#INFO: Resource Guide: https://saylesss88.github.io/installation/enc/encrypted_impermanence.html
{
  inputs,
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  #NOTE: Impermanence: declare persistence under /persist
  environment.persistence."/persist" = {
    enable = true;

    #INFO: System-state that should survive reboots
    directories =
      [
        #INFO: machine identity & logs
        {directory = "/var/lib/systemd";}
        {directory = "/var/log";}

        #INFO: NetworkManager state (connections, wifi, etc.)
        {
          directory = "/etc/NetworkManager/system-connections";
          user = "root";
          group = "root";
          mode = "0700";
        }

        #INFO: SSH host keys
        {
          directory = "/etc/ssh";
          user = "root";
          group = "root";
          mode = "0700";
        }

        #INFO: sops-nix key & secrets path
        {directory = x.sopsPath;} # e.g. /var/lib/sops-nix
      ]
      ++ lib.optionals x.features.enableDocker [
        #INFO: Docker engine state
        {directory = "/var/lib/docker";}
        {directory = "/etc/docker";}
      ]
      ++ lib.optionals x.features.enableLibvirt [
        #INFO: libvirt pools/images & config
        {directory = "/var/lib/libvirt";}
        {directory = "/etc/libvirt";}
      ]
      ++ lib.optionals x.features.enableGaming [
        #INFO: Steam/proton caches & libraries (system paths; user paths below)
        {directory = "/var/lib/steam";}
      ]
      ++ lib.optionals x.features.enableQbittorrent [
        {directory = "/var/lib/qbittorrent";}
        {directory = "/etc/qBittorrent";}
      ];

    #INFO: Per-user state that should persist
    users.${x.identity.username} = {
      directories =
        [
          # Shell & keyring bits you actually want to keep
          ".local/share/keyrings"
          ".local/share/direnv"
          ".local/share/zoxide"
          ".config/NetworkManager" # nm-applet caches, if any
          ".ssh"
          ".gnupg"
        ]
        ++ lib.optionals x.features.enableDocker [
          #INFO: Docker client context
          ".docker"
        ]
        ++ lib.optionals x.features.enableLibvirt [
          ".config/libvirt"
          ".local/share/libvirt"
        ]
        ++ lib.optionals x.features.enableGaming [
          ".local/share/Steam"
          ".steam"
        ]
        ++ lib.optionals x.features.enableZed [
          ".config/zed"
          ".local/share/zed"
        ]
        ++ lib.optionals x.features.enableTypst [
          ".cache/typst" # build cache is nice to keep for speed
        ];

      #INFO: Keep caches ephemeral by default; add selectively above if you want them persisted
      files = [".config/machine-id"];
    };
  };
}
