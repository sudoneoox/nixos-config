{
  outputs,
  inputs,
  custom_vars,
  lib,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      #INFO: Base System and Nix configurations
      ../../modules/base

      #INFO: Defines X0.security options
      ../../modules/security

      #INFO: For scripts used throughout configuration files and systemd-units
      ../../modules/system/utils

      #INFO: Network conf
      ../../modules/system/network

      ../../modules/system/desktop/hyprland
      ../../modules/system/virtualisation
    ]
    ++ lib.optionals custom_vars.ENABLE_GAMING [
      ../../modules/system/gaming
    ];

  X0.security = {
    acipd.enable = true;
    blacklistedModules.enable = true;
    bluetooth.enable = custom_vars.ENABLE_BLUETOOTH;
    boot.enable = true;
    cups.enable = custom_vars.ENABLE_PRINTING;
    dbus.enable = true;
    doas.enable = true;
    fail2ban.enable = custom_vars.ENABLE_SSH;
    getty.enable = true;
    kernel.enable = true;
    network-manager.enable = true;
    network-manager-dispatcher.enable = true;
    #WARN:
    # Gives issues with:
    # nh os switch
    # nix run
    nix-daemon.enable = false;
    reload-systemd-vconsole-setup.enable = true;
    rtkit.enable = true;
    ssh.enable = custom_vars.ENABLE_SSH;
    systemd-ask-password-console.enable = true;
    systemd.enable = true;
    tor.enable = true;
    usbguard.enable = true;
    user.enable = true;
    wpa-supplicant.enable = true;
  };

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
        custom_vars
        ;
    };
    users.${custom_vars.USERNAME} = {
      imports = [
        ./home.nix
      ];
    };
  };
}
