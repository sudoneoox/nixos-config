{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableRstudio {
    home.packages = with pkgs; [
      (rWrapper.override {
        packages = with rPackages; [
          ggplot2
          rmarkdown
          lattice
          vioplot
          GGally
          readr
          dplyr
          knitr
        ];
      })
      rstudio
      pandoc
      quarto

      (texlive.combine {
        inherit
          (texlive)
          scheme-small
          latexmk
          xetex
          collection-latexextra # <- brings framed/fvextra/mdframed/tcolorbox/etc.
          collection-fontsrecommended
          fontspec
          hyperref
          ; # (safe to list explicitly)
      })
    ];
  };
}
