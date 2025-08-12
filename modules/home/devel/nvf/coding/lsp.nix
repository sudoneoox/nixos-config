# ── LSP helpers & docs (maximal) ──────────────────────────────────────────
{
  programs.nvf.settings.vim.lsp = {
    formatOnSave = true;
    enable = true;
    lightbulb.enable = true; # code action lightbulb
    trouble.enable = true; # diagnostics list (Trouble)
    lspSignature.enable = false; # conflics with Blink
    otter-nvim.enable = true; # literate/code chunks support (otter.nvim)
    nvim-docs-view.enable = true; # side pane for docs (nvim-docs-view)
  };
}
