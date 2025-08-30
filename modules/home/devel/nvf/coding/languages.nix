# ── Languages (Treesitter/LSP toggles) ───────────────────────────────────── languages = {
{custom, ...}: let
  x = custom.x0;
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
      enable = x.features.enableRStudio;
      format.enable = x.features.enableRStudio;
      lsp.enable = x.features.enableRStudio;
      treesitter.enable = x.features.enableRStudio;
    };
    typst = {
      enable = x.features.enableTypst;
      format.enable = x.features.enableTypst;
      lsp.enable = x.features.enableTypst;
      treesitter.enable = x.features.enableTypst;
    };
  };
}
