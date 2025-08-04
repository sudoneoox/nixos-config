{ pkgs, ... }:
{

  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = "${pkgs.snvim}";
    };
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withPython3 = true;
      withNodeJs = true;
    };
  };

  home.packages = with pkgs; [
    xclip
    wl-clipboard

    fd
    texliveFull
    ghostscript_headless
    mermaid-cli

    gcc
    neovide

    nil # Language server
    alejandra # Code Formatter
    deadnix # Find and remove unused
    statix # Lints and suggestions

    #lua
    luarocks

    # ts
    typescript

    gdu
  ];
}
