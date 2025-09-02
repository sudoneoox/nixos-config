{
  pkgs,
  lib,
  custom,
  ...
}: let
  x = custom.x0;

  # single source of truth for packages
  rPkgs = with pkgs.rPackages; [
    ggplot2
    rmarkdown
    lattice
    vioplot
    GGally
    readr
    dplyr
    knitr
  ];

  myR = pkgs.rWrapper.override {packages = rPkgs;}; # terminal R
  myRStudio = pkgs.rstudioWrapper.override {packages = rPkgs;}; # RStudio
in {
  config = lib.mkIf x.features.enableRStudio {
    home.packages = [
      myR
      myRStudio
      pkgs.pandoc
      pkgs.quarto
      (pkgs.texlive.combine {
        inherit
          (pkgs.texlive)
          scheme-small
          latexmk
          xetex
          collection-latexextra
          collection-fontsrecommended
          fontspec
          hyperref
          ;
      })
    ];
  };
}
