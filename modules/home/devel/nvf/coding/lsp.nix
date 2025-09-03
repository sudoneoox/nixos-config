{config, ...}:
# ── LSP helpers & docs (maximal) ──────────────────────────────────────────
{
  programs.nvf.settings.vim.lsp = {
    enable = true;
    # Conform handles this
    formatOnSave = !config.programs.nvf.settings.vim.formatter.conform-nvim.enable;
    lightbulb = {
      enable = true; # code action lightbulb
      setupOpts = {
        virtual_text.enabled = false;
        status_text.enabled = false;
        sign.enabled = true;
        ignore.clients = ["null-ls"];
      };
    };
    trouble.enable = true; # diagnostics list (Trouble)
    lspSignature.enable = false;

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
