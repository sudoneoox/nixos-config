{
  outputs,
  inputs,
  X0,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    #INFO: Base System and Nix configurations
    ../../modules/base

    #INFO: Defines X0.security options
    ../../modules/security

    #INFO: For scripts used throughout configuration files and systemd-units
    ../../modules/system/utils

    ../../modules/system/desktop/hyprland
    ../../modules/system/virtualisation
    ../../modules/system/gaming
  ];

  programs = {
    # System wide
    zsh.enable = true;
    git.enable = true;
    fish.enable = true;
  };
  environment.systemPackages = with pkgs; [jq];

  home-manager = {
    backupFileExtension = "hm-backup";
    useUserPackages = true;
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        X0
        ;
    };
    users.${X0.USERNAME} = {
      imports = [
        ./home.nix
      ];
    };
  };
}
