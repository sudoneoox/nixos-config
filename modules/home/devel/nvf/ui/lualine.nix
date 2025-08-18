# ── statusline / tabline / file tree ──────────────────────────────────────
{
  programs.nvf.settings.vim = {
    statusline.lualine = {
      enable = true;
      theme = "neopywal";
    };
    tabline.nvimBufferline.enable = true; # Tabline with buffers
    filetree.neo-tree.enable = true; # Sidebar file explorer
  };
}
