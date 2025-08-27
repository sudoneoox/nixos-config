{pkgs, ...}: {
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
}
