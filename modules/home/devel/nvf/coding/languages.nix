# ── Languages (Treesitter/LSP toggles) ───────────────────────────────────── languages = {
{X0, ...}: {
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableDAP = false;
    enableTreesitter = true;
    enableExtraDiagnostics = true;
    nix.enable = true;
    python = {
      enable = true;
      dap.enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
    clang = {
      enable = true;
      dap.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
    markdown.enable = true;
    lua.enable = true;
    bash.enable = true;
    r = {
      enable = X0.FEATURES.ENABLE_RSTUDIO;
      format.enable = X0.FEATURES.ENABLE_RSTUDIO;
      lsp.enable = X0.FEATURES.ENABLE_RSTUDIO;
      treesitter.enable = X0.FEATURES.ENABLE_RSTUDIO;
    };
    typst = {
      enable = X0.FEATURES.ENABLE_TYPST;
      format.enable = X0.FEATURES.ENABLE_TYPST;
      lsp.enable = X0.FEATURES.ENABLE_TYPST;
      treesitter.enable = X0.FEATURES.ENABLE_TYPST;
    };
  };
}
