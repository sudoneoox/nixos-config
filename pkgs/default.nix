{ pkgs }:

let
  python3 = pkgs.python3.withPackages (
    ps: with ps; [
      click
      more-itertools
    ]
  );
in
{
  hyprshade-git = pkgs.callPackage ./hyprshade-git {
    inherit (pkgs.python3Packages) buildPythonPackage hatchling;
    click = python3.pkgs.click;
    more-itertools = python3.pkgs.more-itertools;
    hyprland = pkgs.hyprland;
    makeWrapper = pkgs.makeWrapper;
  };

}
