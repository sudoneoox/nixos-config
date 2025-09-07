{
  outputs,
  custom,
  inputs,
  pkgs,
  lib,
  ...
}: let
  x = custom.x0;
in {
  imports = [
    inputs.nvf.homeManagerModules.default

    ../../modules/home/devel
    ../../modules/home/desktop/zen-browser
    ../../modules/home/desktop/nixcord
    ../../modules/home/desktop/hyprland
    ../../modules/home/desktop/cursors
    ../../modules/home/utils
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-black";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.additions
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = x.identity.username;
    homeDirectory = x.derived.homeDir;
  };

  programs = {
    home-manager.enable = true;
  };
  systemd.user.startServices = "sd-switch";
}
