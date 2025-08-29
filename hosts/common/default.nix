{
  outputs,
  inputs,
  custom,
  pkgs,
  ...
}: let
  x = custom.x0;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    #INFO: Base System and Nix configurations
    ../../modules/base

    #INFO: Defines config.security options
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
        custom
        ;
    };
    users.${x.identity.username} = {
      imports = [./home.nix];
    };
  };
}
