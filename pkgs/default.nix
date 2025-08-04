{ pkgs, ... }:
{
  arc-icon-theme = pkgs.callPackage ./icons/arc-icon-theme.nix { };
  hyprshade-git = pkgs.callPackage ./hyprshade-git { };
}
