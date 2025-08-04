{
  username,
  outputs,
  inputs,
  email,
  pkgs,
  config,
  ...
}:

{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.nix-index
    ../../modules/base
  ];

  sops.defaultSopsFile = ./common.secrets.enc.yaml;
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  sops.secrets = {
    "wifi-psk" = {
      owner = "root";
      mode = "0400";
    };
  };

  networking = {
    hostName = "X0NixOSLaptop";
    networkmanager.enable = true;
    networkmanager.ensureProfiles = {
      secrets.entries = [
        {
          matchId = "ATTRpV6p4h"; # SSID
          matchSetting = "802-11-wireless-security";
          key = "psk";
          file = config.sops.secrets."wifi-psk".path;
        }
      ];

      profiles."HomeWiFi" = {
        connection = {
          id = "HomeWiFi";
          type = "802-11-wireless";
          interface-name = "wlo1";
          uuid = "bea8b595-75a5-43ed-991a-4728cdfb8762";
        };

        "802-11-wireless" = {
          ssid = "ATTRpV6p4h";
          mode = "infrastructure";
          security = "802-11-wireless-security";
        };

        "802-11-wireless-security" = {
          key-mgmt = "wpa-psk";
        };

        ipv4 = {
          method = "auto";
        };

        ipv6 = {
          method = "auto";
        };
      };
    };
    firewall.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    source-code-pro
  ];

  fonts.enableDefaultPackages = true;

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  home-manager = {
    backupFileExtension = "hm-backup";
    useUserPackages = true;
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        username
        email
        ;
    };
    users.${username} = {
      imports = [
        ./home.nix
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

}
