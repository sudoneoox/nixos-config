{ pkgs, ... }:
{

  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = "${pkgs.snvim}";
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
    lua
    # ts
    typescript
    gdu
    ripgrep
  ];

  home.sessionVariables.EDITOR = "nvim";
}
