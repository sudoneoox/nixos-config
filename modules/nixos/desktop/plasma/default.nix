{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    kdePackages.kate
  ];

  programs.dconf.enable = true;

  qt.enable = true;

  xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}

