# ── Treesitter extras ─────────────────────────────────────────────────────
{
  programs.nvf.settings.vim.treesitter = {
    enable = true;
    context = {
      enable = true; # ts-context: sticky scope header
      setupOpts = {
        max_lines = 5; # keep tiny header
        multiline_threshold = 10;
      };
    };
    highlight.disable = ["help" "vimdoc"];
  };
}
