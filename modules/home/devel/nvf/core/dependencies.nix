{pkgs, ...}: {
  home.packages = with pkgs; [
    # fzf-lua [required]
    fzf
    git
    ripgrep
    uutils-findutils
    # fzf-lua [optional: media]
    viu
    chafa
    ueberzugpp
    # Snacks.image
    ghostscript
  ];
}
