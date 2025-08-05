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
  sops.age.keyFile = "/home/${username}/Assets/nixos-config/sops/age/common-keys.txt";
  sops.secrets = {
    "wireless.env".sopsFile = ./common.secrets.enc.yaml;
  };

  networking = {
    hostName = "X0NixOSLaptop";
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.2"
      "1.0.0.2"
    ];
    networkmanager.ensureProfiles = {
      environmentFiles = [ config.sops.secrets."wireless.env".path ];

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
