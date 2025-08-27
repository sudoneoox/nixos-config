# ── Languages (Treesitter/LSP toggles) ───────────────────────────────────── languages = {
{custom_vars, ...}: {
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
      enable = custom_vars.FEATURES.ENABLE_RSTUDIO;
      format.enable = custom_vars.FEATURES.ENABLE_RSTUDIO;
      lsp.enable = custom_vars.FEATURES.ENABLE_RSTUDIO;
      treesitter.enable = custom_vars.FEATURES.ENABLE_RSTUDIO;
    };
    typst = {
      enable = custom_vars.FEATURES.ENABLE_TYPST;
      format.enable = custom_vars.FEATURES.ENABLE_TYPST;
      lsp.enable = custom_vars.FEATURES.ENABLE_TYPST;
      treesitter.enable = custom_vars.FEATURES.ENABLE_TYPST;
    };
  };
}
