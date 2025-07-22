{ lib, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    kdePackages.kate
  ];

  qt.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}

