{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
    package = pkgs.hyprland-git.hyprland;
    portalPackage = pkgs.hyprland-git.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisble
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint electron apps to use wauland
    NIXOS_OZONE_WL = "1";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    eww
  ];

}
