{
  programs.nixvim.colorschemes.catppuccin = {
    enable = true;
    settings.integrations = {
      gitsigns = true; 
      which_key = true;
      telescope = true;
      treesitter = true;
      lsp_trouble = true;
      mason = true; 
      noice = true;
      notify = true;
      neotree = true;
    };
  };
}
