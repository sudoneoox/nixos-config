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
    # Toggle able options in modules/x0/values.nix
    ../../modules/security

    # ../../modules/system/android

    #INFO: For scripts used throughout configuration files and systemd-units
    ../../modules/system/utils

    ../../modules/system/desktop/hyprland

    # INFO: Only enabled if enabled in modules/x0/values.nix
    ../../modules/system/virtualisation
    ../../modules/system/gaming
  ];

  programs = {
    # System wide
    zsh.enable = true;
    git.enable = true;
    fish.enable = true;
  };

  environment.systemPackages = with pkgs; [
    jq
    localsend
    libreoffice-fresh
    google-chrome
  ];

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
