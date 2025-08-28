# ── Languages (Treesitter/LSP toggles) ───────────────────────────────────── languages = {
{config, ...}: {
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
      enable = config.x0.features.enableRstudio;
      format.enable = config.x0.features.enableRstudio;
      lsp.enable = config.x0.features.enableRstudio;
      treesitter.enable = config.x0.features.enableRstudio;
    };
    typst = {
      enable = config.x0.features.enableTypst;
      format.enable = config.x0.features.enableTypst;
      lsp.enable = config.x0.features.enableTypst;
      treesitter.enable = config.x0.features.enableTypst;
    };
  };
}
