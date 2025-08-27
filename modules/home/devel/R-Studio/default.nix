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
        ];
      })
      rstudio
      pandoc
      quarto
      (texlive.combine {inherit (texlive) scheme-small latexmk;})
    ];
  };
}
