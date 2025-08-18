{
  username,
  outputs,
  inputs,
  email,
  pkgs,
  host,
  custom_vars,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/base

    #INFO: Defines X0.security options
    ../../modules/security

    #INFO: For scripts used throughout configuration files and systemd-units
    ../../modules/system/utils

    #INFO: Network conf
    ../../modules/system/network

    ../../modules/system/desktop/hyprland
  ];

  X0.security = {
    blacklistedModules.enable = true;
    bluetooth.enable = true;
    boot.enable = true;
    cups.enable = true;
    doas.enable = true;
    fail2ban.enable = true;
    kernel.enable = true;
    network-manager.enable = true;
    network-manager-dispatcher.enable = true;
    ssh.enable = true;
    systemd.enable = true;
    tor.enable = true;
    usbguard.enable = true;
    wpa-supplicant.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
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
    # System wide
    zsh.enable = true;
    git.enable = true;
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
        host
        custom_vars
        ;
    };
    users.${username} = {
      imports = [
        ./home.nix
      ];
    };
  };
}
