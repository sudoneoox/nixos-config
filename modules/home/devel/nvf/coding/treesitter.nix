# ── Treesitter extras ─────────────────────────────────────────────────────
{
  programs.nvf.settings.vim.treesitter = {
    enable = true;
    context.enable = true; # ts-context: sticky scope header
  };
}
