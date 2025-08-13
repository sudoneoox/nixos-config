# ── Git tooling ───────────────────────────────────────────────────────────
{
  # enabling vim.git enabled
  # - gitsigns
  # - hunk-nvim
  # - vim-fugitive
  # - git-conflict
  # - gitlinker-nvim
  programs.nvf.settings.vim.git = {
    enable = true;
    gitsigns.codeActions.enable = true;
  };

  programs.nvf.settings.vim.utility.diffview-nvim.enable = true;
}
