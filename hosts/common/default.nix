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
    ++ lib.optionals custom_vars.FEATURES.ENABLE_GAMING [
      ../../modules/system/gaming
    ];

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
