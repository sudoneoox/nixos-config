{ pkgs, lib, custom_vars, ... }:
{

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

  qt.enable = true;
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {enableWlrSupport = true;};
    settings = {
      General = {
        useGrimAdapter = lib.mkIf (custom_vars.DE == "hyprland") true;
        startupLaunch = false;
        autoCloseIdleDaemon = true;
        allowMultipleGuiInstances = false;
        uploadWithoutConfirmation = false;
        copyPathAfterSave = true;
      };
    };
  };

  home.packages = with pkgs; [
    proton-pass
  ];

  home.stateVersion = "25.05";
}
