{
  programs.nixvim.trouble = {
    enable = true;
    keymaps = {
      "<leader>xx" = { action = "<cmd>Trouble diagnostics toggle<cr>"; desc = "Diagnostics (Trouble)"; };
      "<leader>xX" = { action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"; desc = "Buffer Diagnostics (Trouble)"; };
      "<leader>cs" = { action = "<cmd>Trouble symbols toggle<cr>"; desc = "Symbols (Trouble)"; };
      "<leader>cS" = { action = "<cmd>Trouble lsp toggle<cr>"; desc = "LSP references/definitions/... (Trouble)"; };
      "<leader>xL" = { action = "<cmd>Trouble loclist toggle<cr>"; desc = "Location List (Trouble)"; };
      "<leader>xQ" = { action = "<cmd>Trouble qflist toggle<cr>"; desc = "Quickfix List (Trouble)"; };
      "<leader>xT" = { action = ":lua require('trouble').toggle({ keywords = { 'TODO','FIX','FIXME' } })<CR>"; desc = "Todo/Fix/Fixme (Trouble)"; };
      "<leader>xt" = { action = ":lua require('trouble').toggle({ keywords = { 'TODO' } })<CR>"; desc = "Todo (Trouble)"; };
      "[q" = { action = ":lua require('trouble').previous({ skip_groups = true, jump = true })<CR>"; desc = "Prev Trouble/Quickfix"; };
      "]q" = { action = ":lua require('trouble').next({ skip_groups = true, jump = true })<CR>"; desc = "Next Trouble/Quickfix"; };
    };
  };
}
