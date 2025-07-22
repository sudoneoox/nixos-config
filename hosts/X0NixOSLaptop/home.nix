{ pkgs, username, ... }:
{

  imports = [
  ../../modules/home/desktop/awesome
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
    package = pkgs.flameshot.override { enableWlrSupport = true; };
  };

  home.packages = with pkgs; [
    proton-pass
  ];

  home.stateVersion = "25.05";
}
