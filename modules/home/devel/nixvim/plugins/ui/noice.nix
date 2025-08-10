{
  programs.nixvim.plugins.noice = {
    enable = true;
    settings = {
      views = {
        cmdline_popup = { position = { row = 35; col = "50%"; } };
        cmdline_popupmenu = { position = { row = 38; col = "50%"; } };
        mini = { win_options = { winblend = 0; }; };
      };
      lsp = { progress = { enabled = false; }; hover = { silent = true; }; };
      presets = { lsp_doc_border = true; };
      routes = [
        { filter = { event = "msg_show"; find = "written"; }; }
        { filter = { event = "msg_show"; find = "yanked"; }; }
        { filter = { event = "msg_show"; find = "%d+L, %d+B"; }; }
        { filter = { event = "msg_show"; find = "; after #%d+"; }; }
        { filter = { event = "msg_show"; find = "; before #%d+"; }; }
        { filter = { event = "msg_show"; find = "%d fewer lines"; }; }
        { filter = { event = "msg_show"; find = "%d more lines"; }; }
        { filter = { event = "msg_show"; find = "%d lines indented"; }; }
        { filter = { event = "msg_show"; find = "%d lines moved"; }; }
        { filter = { event = "msg_show"; find = "<ed"; }; }
        { filter = { event = "msg_show"; find = ">ed"; }; }
        { filter = { event = "lsp"; kind = "progress"; find = "jdtls"; }; }
      ];
    };
    keymaps = {
      "<leader>nt" = { action = ":lua require('telescope').extensions.notify.notify()<CR>"; desc = "Notification History"; };
      "<leader>np" = { action = ":lua require('telescope').extensions.noice.telescope()<CR>"; desc = "Noice Picker"; };
      "<leader>nd" = { action = ":Noice dismiss<CR>"; desc = "Dismiss All"; };
      "<leader>na" = { action = ":Noice all<CR>"; desc = "Noice All"; };
      "<leader>nh" = { action = ":Noice history<CR>"; desc = "Noice History"; };
      "<leader>nl" = { action = ":Noice last<CR>"; desc = "Noice Last Message"; };
      "<leader>nD" = { action = ":lua require('notify').dismiss()<CR>"; desc = "Dismiss All Notifications"; };
    };
  };
}
