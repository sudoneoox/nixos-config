# ── Binds  ────────────────────────────────────────────────────────────────
{
  programs.nvf.settings.vim.binds = {
    whichKey = {
      enable = true;
      setupOpts = {
        preset = "modern";
        win = {
          border = "none";
        };
      };
      register = {
        # remove groups that have no keybinds
        "<leader>d" = "debugger";
        "<leader>h" = null;
        "<leader>g" = "git";
        "<leader>um" = "Minimap";
        "<leader>gS" = "GitSigns";
        "<leader>t" = "Trouble";
        "<leader>lw" = null;
        "<leader>x" = null;
        "<leader>u" = "ui";
        "<leader>c" = "Code";
        "<leader>cg" = "Go to";
        "<leader>cG" = "Git Diff";
        "<leader>cw" = "Workspaces";
      };
    };
  };
}
