{
  pkgs,
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  imports = [
    ../../modules/home/desktop/vesktop
    ../../modules/home/desktop/cider
    ../../modules/home/desktop/mpv
  ];

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

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {enableWlrSupport = true;};
    settings = {
      General = {
        useGrimAdapter = lib.mkIf (x.ux.de == "hyprland") true;
        startupLaunch = false;
        autoCloseIdleDaemon = true;
        allowMultipleGuiInstances = false;
        uploadWithoutConfirmation = false;
        copyPathAfterSave = true;
      };
    };
  };

  home.stateVersion = "25.05";
}
