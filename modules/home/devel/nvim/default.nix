{
  lib,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter
    ];
    extraPackages = with pkgs; [
      tree-sitter
      lua54Packages.jsregexp
      tree-sitter-grammars.tree-sitter-lua
      tree-sitter-grammars.tree-sitter-go
      tree-sitter-grammars.tree-sitter-nix
      tree-sitter-grammars.tree-sitter-python
      tree-sitter-grammars.tree-sitter-bash
      tree-sitter-grammars.tree-sitter-regex
      tree-sitter-grammars.tree-sitter-markdown
      tree-sitter-grammars.tree-sitter-json

      nodejs_24
      nodePackages_latest.vscode-json-languageserver
      fzf
      lua-language-server
      nixd
      go
      gopls
      gofumpt
      stylua
      cargo
      rustc
      basedpyright
      ruff
      nixfmt-rfc-style
      zls
      ripgrep
      imagemagick
    ];
  };

  xdg.desktopEntries = lib.optionalAttrs pkgs.stdenv.isLinux {
    neovim = {
      name = "Neovim";
      genericName = "editor";
      exec = "nvim -f %F";
      mimeType = [
        "text/html"
        "text/xml"
        "text/plain"
        "text/english"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-tex"
        "application/x-shellscript"
      ];
      terminal = false;
      type = "Application";
    };
  };

  home.packages = with pkgs; [
    xclip
    wl-clipboard
  ];

  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = "${pkgs.snvim}";
    };
  };

}
