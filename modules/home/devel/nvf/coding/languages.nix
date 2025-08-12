# ── Languages (Treesitter/LSP toggles) ───────────────────────────────────── languages = {
{
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableDAP = false;
    enableTreesitter = true;
    enableExtraDiagnostics = true;
    nix.enable = true;
    python.enable = true;
    clang = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
    markdown.enable = true;
    lua.enable = true;
    bash.enable = true;
  };
}
