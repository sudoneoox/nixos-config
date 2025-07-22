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
    ripgrep

  ];
}
