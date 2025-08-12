{
  programs.nvf.settings.vim.keymaps = [
    # NOTE: General
    {
      key = "<leader>w";
      mode = ["n"];
      action = ":w<CR>";
      desc = "Save File";
    }
    {
      key = "<leader>q";
      mode = ["n"];
      action = ":wq<CR>";
      desc = "Quit and Save File";
    }

    # NOTE: Telescope
    {
      key = "<leader>ff";
      mode = ["n"];
      action = ":Telescope find_files<CR>";
      desc = "Find files [Telescope]";
    }
    {
      key = "<Leader>fg";
      mode = ["n"];
      action = ":Telescope live_grep<CR>";
      desc = "Live grep [Telescope]";
    }
    {
      key = "<Leader>fb";
      mode = ["n"];
      action = ":Telescope buffers<CR>";
      desc = "List buffers [Telescope]";
    }
    {
      key = "<Leader>fh";
      mode = ["n"];
      action = ":Telescope help_tags<CR>";
      desc = "Help tags [Telescope]";
    }
    {
      key = "<Leader>fr";
      mode = ["n"];
      action = ":Telescope oldfiles<CR>";
      desc = "Recent files [Telescope]";
    }

    # NOTE: Neo-tree
    {
      key = "<Leader>fe";
      mode = ["n"];
      action = ":Neotree toggle<CR>";
      desc = "Toggle file tree [Neotree]";
    }
    {
      key = "<Leader>fE";
      mode = ["n"];
      action = ":Neotree float<CR>";
      desc = "Open file tree in float [Neotree]";
    }

    # NOTE: Gitsigns
    {
      key = "[c";
      mode = ["n"];
      action = ":Gitsigns prev_hunk<CR>";
      desc = "Prev hunk";
    }
    {
      key = "]c";
      mode = ["n"];
      action = ":Gitsigns next_hunk<CR>";
      desc = "Next hunk";
    }
    {
      key = "<Leader>gSs";
      mode = ["n"];
      action = ":Gitsigns stage_hunk<CR>";
      desc = "Stage hunk [GitSigns]";
    }
    {
      key = "<Leader>gSr";
      mode = ["n"];
      action = ":Gitsigns reset_hunk<CR>";
      desc = "Reset hunk [GitSigns]";
    }
    {
      key = "<Leader>gSp";
      mode = ["n"];
      action = ":Gitsigns preview_hunk<CR>";
      desc = "Preview hunk [GitSigns]";
    }
    {
      key = "<Leader>gSb";
      mode = ["n"];
      action = ":Gitsigns blame_line<CR>";
      desc = "Blame line [GitSigns]";
    }
    {
      key = "<Leader>gSd";
      mode = ["n"];
      action = ":Gitsigns diffthis<CR>";
      desc = "Diff this [GitSigns]";
    }
    {
      key = "<Leader>gSu";
      mode = ["n"];
      action = ":Gitsigns undo_stage_hunk<CR>";
      desc = "Undo Stage Hunk [GitSigns]";
    }
    {
      key = "<Leader>gSt";
      mode = ["n"];
      action = ":Gitsigns toggle_current_line_blame<CR>";
      desc = "Toggle Current Line Blame[GitSigns]";
    }

    # NOTE: Trouble
    {
      key = "<Leader>tx";
      mode = ["n"];
      action = ":Trouble<CR>";
      desc = " Trouble Cmd List [Trouble]";
    }
    {
      key = "<Leader>tD";
      mode = ["n"];
      action = ":Trouble diagnostics<CR>";
      desc = "Document diagnostics [Trouble]";
    }
    {
      key = "<Leader>tl";
      mode = ["n"];
      action = ":Trouble loclist<CR>";
      desc = "LOC List [Trouble]";
    }
    {
      key = "<Leader>tq";
      mode = ["n"];
      action = ":Trouble quickfix<CR>";
      desc = "Quickfix list [Trouble]";
    }
    {
      key = "<Leader>ts";
      mode = ["n"];
      action = ":Trouble symbols<CR>";
      desc = "Symbols List [Trouble]";
    }

    # NOTE: Toggle Term
    {
      key = "<Leader>/";
      mode = ["n"];
      action = ":ToggleTerm<CR>";
      desc = "Toggle Terminal [Toggle Term]";
    }
    {
      key = "<Leader>/";
      mode = ["t"];
      action = "<C-\\><C-n>:ToggleTerm<CR>";
      desc = "Toggle Terminal [Toggle Term]";
    }

    # NOTE: UI

    # {
    #   key = "<Leader>us";
    #   mode = ["n"];
    #   action = "<cmd>lua Snacks.toggle.option('spell', { name = 'Spelling' })()<CR>";
    #   desc = "Toggle Spelling [Snacks]";
    # }

    # NOTE: Extra

    # Exit insert mode quick cmd
    {
      key = "jk";
      mode = ["i"];
      action = "<ESC>";
      desc = "Exit insert mode";
    }
    # Primeagen move selected text up or down
    {
      key = "J";
      mode = ["v"];
      action = ":m '>+1<CR>gv=gv";
      desc = "";
    }
    {
      key = "K";
      mode = ["v"];
      action = ":m '<-2<cr>gv=gv";
      desc = "";
    }
    {
      key = "<leader>p";
      mode = ["x"];
      action = "'_dP";
      desc = "";
    }
    # Stay in visual mode whenever indenting selected text
    {
      key = "<";
      mode = ["v"];
      action = "<gv";
      desc = "";
    }
    {
      key = ">";
      mode = ["v"];
      action = ">gv";
      desc = "";
    }
  ];
}
