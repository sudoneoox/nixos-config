{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = { action = "find_files"; desc = "Find files"; };
      "<leader>fg" = { action = "live_grep";  desc = "Grep"; };
      "<leader>fb" = { action = "buffers";    desc = "Buffers"; };
    }; 
  };
}
