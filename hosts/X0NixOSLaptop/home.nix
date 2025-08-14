{pkgs, ...}: {
  imports = [
    ../../modules/home/desktop/hyprland
    ../../modules/home/desktop/wallust
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
  };

  home.packages = with pkgs; [
    proton-pass
  ];

  home.stateVersion = "25.05";
}
