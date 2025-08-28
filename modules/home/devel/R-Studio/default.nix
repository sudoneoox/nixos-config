{
  pkgs,
  lib,
  X0,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_RSTUDIO {
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
