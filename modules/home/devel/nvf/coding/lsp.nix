# ── LSP helpers & docs (maximal) ──────────────────────────────────────────
{
  programs.nvf.settings.vim.lsp = {
    enable = true;
    formatOnSave = true;
    lightbulb = {
      enable = true; # code action lightbulb
      setupOpts = {
        virtual_text.enabled = false;
        status_text.enabled = false;
        sign.enabled = true;
      };
    };
    trouble.enable = true; # diagnostics list (Trouble)
    lspSignature.enable = false;

    otter-nvim.enable = true; # literate/code chunks support (otter.nvim)
    # side pane for docs (nvim-docs-view)
    nvim-docs-view = {
      enable = true;
      setupOpts = {
        position = "bottom";
        width = 15;
        update_mode = "auto";
      };
    };
  };
}
