{
  pkgs,
  lib,
  custom_vars,
  ...
}: {
  config = lib.mkIf custom_vars.FEATURES.ENABLE_RSTUDIO {
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
