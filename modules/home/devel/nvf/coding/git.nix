# ── Git tooling ───────────────────────────────────────────────────────────
{
  programs.nvf.settings.vim.git = {
    enable = true;
    gitsigns.enable = true; # inline hunks
    gitsigns.codeActions.enable = true;
    neogit.enable = true; # magit-like UI
  };

  programs.nvf.settings.vim.utility.diffview-nvim.enable = true;
}
