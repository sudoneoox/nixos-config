# ── Languages (Treesitter/LSP toggles) ───────────────────────────────────── languages = {
{config, ...}: let
  x = config.x0;
in {
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
      enable = x.features.enableRstudio;
      format.enable = x.features.enableRstudio;
      lsp.enable = x.features.enableRstudio;
      treesitter.enable = x.features.enableRstudio;
    };
    typst = {
      enable = x.features.enableTypst;
      format.enable = x.features.enableTypst;
      lsp.enable = x.features.enableTypst;
      treesitter.enable = x.features.enableTypst;
    };
  };
}
