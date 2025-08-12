# ── Binds  ────────────────────────────────────────────────────────────────
{
  programs.nvf.settings.vim.binds = {
    whichKey = {
      enable = true;
      setupOpts = {
        preset = "modern";
        win = {border = "none";};
      };
      register = {
        # remove groups that have no keybinds
        "<leader>h" = null;
        "<leader>gS" = "GitSigns";
        "<leader>t" = "Trouble";
        "<leader>x" = null;
      };
    };
  };
}
