# ── LSP helpers & docs (maximal) ──────────────────────────────────────────
{
  programs.nvf.settings.vim.lsp = {
    formatOnSave = true;
    enable = true;
    lightbulb.enable = true; # code action lightbulb
    trouble.enable = true; # diagnostics list (Trouble)
    lspSignature.enable = false; # conflics with Blink
    otter-nvim.enable = true; # literate/code chunks support (otter.nvim)
    # side pane for docs (nvim-docs-view)
    nvim-docs-view = {
      enable = true;
      setupOpts = {
        position = "right";
        width = 60;
        update_mode = "auto";
      };
    };
  };
}
