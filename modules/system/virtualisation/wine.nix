{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    winetricks
  ];

  services.flatpak.enable = true;
}
