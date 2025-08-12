# ── statusline / tabline / file tree ──────────────────────────────────────
{
  programs.nvf.settings.vim = {
    statusline.lualine = {
      enable = true;
      theme = "github_dark_high_contrast";
    };
    tabline.nvimBufferline.enable = true; # Tabline with buffers
    filetree.neo-tree.enable = true; # Sidebar file explorer
  };
}
