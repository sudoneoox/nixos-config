
if vim.loader then
  vim.loader.enable()
end


-- SECTION: theme

require('tokyonight').setup {
  transparent = false;
}
vim.cmd[[colorscheme tokyonight-night]]




-- SECTION: globalsScript
vim.g.editorconfig = true
vim.g.mapleader = " "
vim.g.maplocalleader = ","


-- SECTION: basic








vim.o.smartcase = false
vim.o.ignorecase = false



-- SECTION: optionsScript
vim.o.autoindent = true
vim.o.backspace = "indent,eol,start"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.o.cursorline = true
vim.o.cursorlineopt = "line"
vim.o.encoding = "utf-8"
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.mouse = "nvi"
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.shiftwidth = 2
vim.o.showcmd = true
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.spell = true
vim.o.spelllang = "en"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.tm = 500
vim.o.updatetime = 300
vim.o.visualbell = false
vim.o.wildmenu = true
vim.o.wrap = false
vim.o.writebackup = false


-- SECTION: lazyConfigs
require('lz.n').load({{"blink-cmp",["after"] = function()
  
  require("blink.cmp").setup({["cmdline"] = {["keymap"] = {["<C-Space>"] = {"show","fallback"},["<C-d>"] = {"scroll_documentation_up","fallback"},["<C-e>"] = {"hide","fallback"},["<C-f>"] = {"scroll_documentation_down","fallback"},["<S-Tab>"] = {"select_prev","fallback"},["<Tab>"] = {"select_next","show","fallback"},["preset"] = "none"}},["completion"] = {["documentation"] = {["auto_show"] = true,["auto_show_delay_ms"] = 200},["menu"] = {["auto_show"] = true}},["fuzzy"] = {["implementation"] = "prefer_rust",["prebuilt_binaries"] = {["download"] = false}},["keymap"] = {["<C-Space>"] = {"show","fallback"},["<C-d>"] = {"scroll_documentation_up","fallback"},["<C-e>"] = {"hide","fallback"},["<C-f>"] = {"scroll_documentation_down","fallback"},["<CR>"] = {"accept","fallback"},["<S-Tab>"] = {"select_prev","snippet_backward","fallback"},["<Tab>"] = {"select_next","snippet_forward",function(cmp)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  has_words_before = col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

  if has_words_before then
    return cmp.show()
  end
end
,"fallback"},["preset"] = "none"},["snippets"] = {["preset"] = "luasnip"},["sources"] = {["default"] = {"lsp","path","snippets","buffer"},["providers"] = {}}})
  

end
},{"comment-nvim",["after"] = function()
  
  require("Comment").setup({["mappings"] = {["basic"] = false,["extra"] = false}})
  
end
,["keys"] = {{"gc","<Plug>(comment_toggle_linewise)",["desc"] = "Toggle line comment",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gb","<Plug>(comment_toggle_blockwise)",["desc"] = "Toggle block comment",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gcc",function()
  return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_linewise_current)'
          or '<Plug>(comment_toggle_linewise_count)'
end
,["desc"] = "Toggle current line comment",["expr"] = true,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gbc",function()
  return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_blockwise_current)'
          or '<Plug>(comment_toggle_blockwise_count)'
end
,["desc"] = "Toggle current block comment",["expr"] = true,["mode"] = {"n"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gc","<Plug>(comment_toggle_linewise_visual)",["desc"] = "Toggle selected comment",["expr"] = false,["mode"] = "x",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gb","<Plug>(comment_toggle_blockwise_visual)",["desc"] = "Toggle selected block",["expr"] = false,["mode"] = "x",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"diffview-nvim",["after"] = function()
  
  require("diffview").setup({})
  
end
,["cmd"] = {"DiffviewClose","DiffviewFileHistory","DiffviewFocusFiles","DiffviewLog","DiffviewOpen","DiffviewRefresh","DiffviewToggleFiles"}},{"gitlinker-nvim",["after"] = function()
  
  require("gitlinker").setup({})
  
end
,["cmd"] = {"GitLink"}},{"hunk-nvim",["after"] = function()
  
  require("hunk").setup({})
  
end
},{"icon-picker-nvim",["after"] = function()
  
  require("icon-picker").setup({["disable_legacy_commands"] = true})
  
end
,["cmd"] = {"IconPickerInsert","IconPickerNormal","IconPickerYank"}},{"leap-nvim",["after"] = function()
  
  
  require('leap').opts = {
  max_phase_one_targets = nil,
  highlight_unlabeled_phase_one_targets = false,
  max_highlighted_traversal_targets = 10,
  case_sensitive = false,
  equivalence_classes = { ' \t\r\n', },
  substitute_chars = {},
  safe_labels = {
    "s", "f", "n", "u", "t", "/",
    "S", "F", "N", "L", "H", "M", "U", "G", "T", "?", "Z"
  },
  labels = {
    "s", "f", "n",
    "j", "k", "l", "h", "o", "d", "w", "e", "m", "b",
    "u", "y", "v", "r", "g", "t", "c", "x", "/", "z",
    "S", "F", "N",
    "J", "K", "L", "H", "O", "D", "W", "E", "M", "B",
    "U", "Y", "V", "R", "G", "T", "C", "X", "?", "Z"
  },
  special_keys = {
    repeat_search = '<enter>',
    next_phase_one_target = '<enter>',
    next_target = {'<enter>', ';'},
    prev_target = {'<tab>', ','},
    next_group = '<space>',
    prev_group = '<tab>',
    multi_accept = '<enter>',
    multi_revert = '<backspace>',
  },
}

end
,["keys"] = {{"<leader>ss","<Plug>(leap-forward-to)",["desc"] = "Leap forward to",["expr"] = false,["mode"] = {"n","o","x"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>sS","<Plug>(leap-backward-to)",["desc"] = "Leap backward to",["expr"] = false,["mode"] = {"n","o","x"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>sx","<Plug>(leap-forward-till)",["desc"] = "Leap forward till",["expr"] = false,["mode"] = {"n","o","x"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>sX","<Plug>(leap-backward-till)",["desc"] = "Leap backward till",["expr"] = false,["mode"] = {"n","o","x"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gs","<Plug>(leap-from-window)",["desc"] = "Leap from window",["expr"] = false,["mode"] = {"n","o","x"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"luasnip",["after"] = function()
  
  require("luasnip").setup({["enable_autosnippets"] = false})
  


end
,["lazy"] = true},{"multicursors-nvim",["after"] = function()
  
  require("multicursors").setup({["DEBUG_MODE"] = false,["create_commands"] = true,["generate_hints"] = {["config"] = {["max_hint_length"] = 25},["extend"] = true,["insert"] = true,["normal"] = true},["hint_config"] = {["float_opts"] = {["border"] = "none"},["position"] = "bottom"},["mode_keys"] = {["append"] = "a",["change"] = "c",["extend"] = "e",["insert"] = "i"},["nowait"] = true,["updatetime"] = 50})
  
end
,["cmd"] = {"MCstart","MCvisual","MCclear","MCpattern","MCvisualPattern","MCunderCursor"},["event"] = {"DeferredUIEnter"},["keys"] = {{"<leader>mcs",":MCstart<cr>",["desc"] = "Create a selection for selected text or word under the cursor [multicursors.nvim]",["expr"] = false,["mode"] = {"v","n"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>mcp",":MCpattern<cr>",["desc"] = "Create a selection for pattern entered [multicursors.nvim]",["expr"] = false,["mode"] = {"v","n"},["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"neo-tree-nvim",["after"] = function()
  
  require("neo-tree").setup({["add_blank_line_at_top"] = false,["auto_clean_after_session_restore"] = false,["default_source"] = "filesystem",["enable_cursor_hijack"] = false,["enable_diagnostics"] = true,["enable_git_status"] = true,["enable_modified_markers"] = true,["enable_opened_markers"] = true,["enable_refresh_on_write"] = true,["filesystem"] = {["hijack_netrw_behavior"] = "open_default"},["git_status_async"] = false,["hide_root_node"] = false,["log_level"] = "info",["log_to_file"] = false,["open_files_do_not_replace_types"] = {"terminal","Trouble","qf","edgy"},["open_files_in_last_window"] = true,["retain_hidden_root_indent"] = false})
  
end
,["cmd"] = {"Neotree"}},{"nvim-surround",["after"] = function()
  
  require("nvim-surround").setup({["keymaps"] = {["change"] = "gzr",["change_line"] = "gZR",["delete"] = "gzd",["insert"] = "<C-g>z",["insert_line"] = "<C-g>Z",["normal"] = "gz",["normal_cur"] = "gZ",["normal_cur_line"] = "gZZ",["normal_line"] = "gzz",["visual"] = "gz",["visual_line"] = "gZ"}})
  
end
,["event"] = {"BufReadPre","BufNewFile"},["keys"] = {{"<C-g>z",["expr"] = false,["mode"] = "i",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<C-g>Z",["expr"] = false,["mode"] = "i",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gz",["expr"] = false,["mode"] = "x",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gZ",["expr"] = false,["mode"] = "x",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gz",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gZ",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gzz",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gZZ",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gzd",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gzr",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"gZR",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"smart-splits",["after"] = function()
  
  require("smart-splits").setup({})
  
end
,["event"] = {"DeferredUIEnter"},["keys"] = {{"<A-h>",function() require('smart-splits').resize_left() end,["desc"] = "Resize Window/Pane Left",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<A-j>",function() require('smart-splits').resize_down() end,["desc"] = "Resize Window/Pane Down",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<A-k>",function() require('smart-splits').resize_up() end,["desc"] = "Resize Window/Pane Up",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<A-l>",function() require('smart-splits').resize_right() end,["desc"] = "Resize Window/Pane Right",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<C-h>",function() require('smart-splits').move_cursor_left() end,["desc"] = "Focus Window/Pane on the Left",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<C-j>",function() require('smart-splits').move_cursor_down() end,["desc"] = "Focus Window/Pane Below",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<C-k>",function() require('smart-splits').move_cursor_up() end,["desc"] = "Focus Window/Pane Above",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<C-l>",function() require('smart-splits').move_cursor_right() end,["desc"] = "Focus Window/Pane on the Right",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<C-\\>",function() require('smart-splits').move_cursor_previous() end,["desc"] = "Focus Previous Window/Pane",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader><leader>h",function() require('smart-splits').swap_buf_left() end,["desc"] = "Swap Buffer Left",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader><leader>j",function() require('smart-splits').swap_buf_down() end,["desc"] = "Swap Buffer Down",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader><leader>k",function() require('smart-splits').swap_buf_up() end,["desc"] = "Swap Buffer Up",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader><leader>l",function() require('smart-splits').swap_buf_right() end,["desc"] = "Swap Buffer Right",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"telescope",["after"] = function()
  
  require("telescope").setup({["defaults"] = {["color_devicons"] = false,["entry_prefix"] = "  ",["extensions"] = {["fzf"] = {["fuzzy"] = true}},["file_ignore_patterns"] = {"node_modules","%.git/","dist/","build/","target/","result/"},["initial_mode"] = "insert",["layout_config"] = {["height"] = 0.800000,["horizontal"] = {["preview_width"] = 0.550000,["prompt_position"] = "top"},["preview_cutoff"] = 120,["vertical"] = {["mirror"] = false},["width"] = 0.800000},["layout_strategy"] = "horizontal",["path_display"] = {"absolute"},["pickers"] = {["find_command"] = {"/nix/store/d8gs5vih8f1nkck5q8jrndzxzdkpsl01-fd-10.2.0/bin/fd"}},["prompt_prefix"] = "     ",["selection_caret"] = "  ",["selection_strategy"] = "reset",["set_env"] = {["COLORTERM"] = "truecolor"},["sorting_strategy"] = "ascending",["vimgrep_arguments"] = {"/nix/store/1ijacjhy42pqx7vfi5mnsqrps2k3b8xf-ripgrep-14.1.1/bin/rg","--color=never","--no-heading","--with-filename","--line-number","--column","--smart-case","--hidden","--no-ignore"},["winblend"] = 0},["pickers"] = {["find_files"] = {["find_command"] = {"/nix/store/d8gs5vih8f1nkck5q8jrndzxzdkpsl01-fd-10.2.0/bin/fd","--type=file"}}}})
  local telescope = require("telescope")
telescope.load_extension('noice')

telescope.load_extension('projects')
telescope.load_extension('fzf')

end
,["before"] = function()
  vim.g.loaded_telescope = nil

end
,["cmd"] = {"Telescope"},["keys"] = {{"<leader>ff","<cmd>Telescope find_files<CR>",["desc"] = "Find files [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fg","<cmd>Telescope live_grep<CR>",["desc"] = "Live grep [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fb","<cmd>Telescope buffers<CR>",["desc"] = "Buffers [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fh","<cmd>Telescope help_tags<CR>",["desc"] = "Help tags [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>ft","<cmd>Telescope<CR>",["desc"] = "Open [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fr","<cmd>Telescope resume<CR>",["desc"] = "Resume (previous search) [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fvcw","<cmd>Telescope git_commits<CR>",["desc"] = "Git commits [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fvcb","<cmd>Telescope git_bcommits<CR>",["desc"] = "Git buffer commits [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fvb","<cmd>Telescope git_branches<CR>",["desc"] = "Git branches [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fvs","<cmd>Telescope git_status<CR>",["desc"] = "Git status [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fvx","<cmd>Telescope git_stash<CR>",["desc"] = "Git stash [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>flsb","<cmd>Telescope lsp_document_symbols<CR>",["desc"] = "LSP Document Symbols [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>flsw","<cmd>Telescope lsp_workspace_symbols<CR>",["desc"] = "LSP Workspace Symbols [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>flr","<cmd>Telescope lsp_references<CR>",["desc"] = "LSP References [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fli","<cmd>Telescope lsp_implementations<CR>",["desc"] = "LSP Implementations [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>flD","<cmd>Telescope lsp_definitions<CR>",["desc"] = "LSP Definitions [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>flt","<cmd>Telescope lsp_type_definitions<CR>",["desc"] = "LSP Type Definitions [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fld","<cmd>Telescope diagnostics<CR>",["desc"] = "Diagnostics [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fs","<cmd>Telescope treesitter<CR>",["desc"] = "Treesitter [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>fp","<cmd>Telescope projects<CR>",["desc"] = "Find projects [Telescope]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"toggleterm-nvim",["after"] = function()
  
  require("toggleterm").setup({["direction"] = "horizontal",["enable_winbar"] = false,["size"] = function(term)
  if term.direction == "horizontal" then
    return 15
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.4
  end
end
,["winbar"] = {["enabled"] = true,["name_formatter"] = function(term)
  return term.name
end
}})
  local terminal = require 'toggleterm.terminal'
local lazygit = terminal.Terminal:new({
  cmd = '/nix/store/557v0gyppc9dyq8g3ay40n0sbxqzwaak-lazygit-0.54.1/bin/lazygit',
  direction = 'float',
  hidden = true,
  on_open = function(term)
    vim.cmd("startinsert!")
  end
})

vim.keymap.set('n', "<leader>gg", function() lazygit:toggle() end, {silent = true, noremap = true, desc = 'Open lazygit [toggleterm]'})

end
,["cmd"] = {"ToggleTerm","ToggleTermSendCurrentLine","ToggleTermSendVisualLines","ToggleTermSendVisualSelection","ToggleTermSetName","ToggleTermToggleAll"},["keys"] = {{"<c-t>","<Cmd>execute v:count . \"ToggleTerm\"<CR>",["desc"] = "Toggle terminal",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>gg",["desc"] = "Open lazygit [toggleterm]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"trouble",["after"] = function()
  
  require("trouble").setup({})
  
end
,["cmd"] = "Trouble",["keys"] = {{"<leader>lwd","<cmd>Trouble toggle diagnostics<CR>",["desc"] = "Workspace diagnostics [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>ld","<cmd>Trouble toggle diagnostics filter.buf=0<CR>",["desc"] = "Document diagnostics [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>lr","<cmd>Trouble toggle lsp_references<CR>",["desc"] = "LSP References [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>xq","<cmd>Trouble toggle quickfix<CR>",["desc"] = "QuickFix [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>xl","<cmd>Trouble toggle loclist<CR>",["desc"] = "LOCList [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false},{"<leader>xs","<cmd>Trouble toggle symbols<CR>",["desc"] = "Symbols [trouble]",["expr"] = false,["mode"] = "n",["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false}}},{"undotree",["cmd"] = {"UndotreeToggle","UndotreeShow","UndotreeHide","UndotreePersistUndo","UndotreeFocus"}}})
require('lzn-auto-require').enable()


-- SECTION: pluginConfigs
-- SECTION: lsp-setup
vim.g.formatsave = true;

local attach_keymaps = function(client, bufnr)
  vim.keymap.set('n', '<leader>lgD', vim.lsp.buf.declaration, {buffer=bufnr, noremap=true, silent=true, desc='Go to declaration'})
  vim.keymap.set('n', '<leader>lgd', vim.lsp.buf.definition, {buffer=bufnr, noremap=true, silent=true, desc='Go to definition'})
  vim.keymap.set('n', '<leader>lgt', vim.lsp.buf.type_definition, {buffer=bufnr, noremap=true, silent=true, desc='Go to type'})
  vim.keymap.set('n', '<leader>lgi', vim.lsp.buf.implementation, {buffer=bufnr, noremap=true, silent=true, desc='List implementations'})
  vim.keymap.set('n', '<leader>lgr', vim.lsp.buf.references, {buffer=bufnr, noremap=true, silent=true, desc='List references'})
  vim.keymap.set('n', '<leader>lgn', vim.diagnostic.goto_next, {buffer=bufnr, noremap=true, silent=true, desc='Go to next diagnostic'})
  vim.keymap.set('n', '<leader>lgp', vim.diagnostic.goto_prev, {buffer=bufnr, noremap=true, silent=true, desc='Go to previous diagnostic'})
  vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, {buffer=bufnr, noremap=true, silent=true, desc='Open diagnostic float'})
  vim.keymap.set('n', '<leader>lH', vim.lsp.buf.document_highlight, {buffer=bufnr, noremap=true, silent=true, desc='Document highlight'})
  vim.keymap.set('n', '<leader>lS', vim.lsp.buf.document_symbol, {buffer=bufnr, noremap=true, silent=true, desc='List document symbols'})
  vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, {buffer=bufnr, noremap=true, silent=true, desc='Add workspace folder'})
  vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, {buffer=bufnr, noremap=true, silent=true, desc='Remove workspace folder'})
  vim.keymap.set('n', '<leader>lwl', function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {buffer=bufnr, noremap=true, silent=true, desc='List workspace folders'})
  vim.keymap.set('n', '<leader>lws', vim.lsp.buf.workspace_symbol, {buffer=bufnr, noremap=true, silent=true, desc='List workspace symbols'})
  vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, {buffer=bufnr, noremap=true, silent=true, desc='Trigger hover'})
  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, {buffer=bufnr, noremap=true, silent=true, desc='Signature help'})
  vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {buffer=bufnr, noremap=true, silent=true, desc='Rename symbol'})
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {buffer=bufnr, noremap=true, silent=true, desc='Code action'})
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {buffer=bufnr, noremap=true, silent=true, desc='Format'})
  vim.keymap.set('n', '<leader>ltf', function() vim.b.disableFormatSave = not vim.b.disableFormatSave end, {buffer=bufnr, noremap=true, silent=true, desc='Toggle format on save'})
end

local navic = require("nvim-navic")
default_on_attach = function(client, bufnr)
  attach_keymaps(client, bufnr)
  -- let navic attach to buffers
if client.server_capabilities.documentSymbolProvider then
  navic.attach(client, bufnr)
end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()


capabilities = require('blink.cmp').get_lsp_capabilities()



-- SECTION: lspconfig
local lspconfig = require('lspconfig')

require('lspconfig.ui.windows').default_options.border = "rounded"



-- SECTION: bash-lsp
lspconfig.bashls.setup{
  capabilities = capabilities;
  on_attach = default_on_attach;
  cmd = {"/nix/store/0hxfjhzg4ga188mkrmc3scscixphns9d-bash-language-server-5.6.0/bin/bash-language-server",  "start"};
}


-- SECTION: breadcrumbs

local navic = require("nvim-navic")
require("nvim-navic").setup {
  highlight = true
}


local navbuddy = require("nvim-navbuddy")
local actions = require("nvim-navbuddy.actions")
navbuddy.setup {["icons"] = {["Array"] = "󰅪 ",["Boolean"] = "◩ ",["Class"] = "󰌗 ",["Constant"] = "󰏿 ",["Constructor"] = " ",["Enum"] = "󰕘",["EnumMember"] = "󰕘 ",["Event"] = " ",["Field"] = " ",["File"] = "󰈙 ",["Function"] = "󰊕 ",["Interface"] = "󰕘",["Key"] = "󰌋 ",["Method"] = "󰆧 ",["Module"] = " ",["Namespace"] = "󰌗 ",["Null"] = "󰟢 ",["Number"] = "󰎠 ",["Object"] = "󰅩 ",["Operator"] = "󰆕 ",["Package"] = " ",["Property"] = " ",["String"] = " ",["Struct"] = "󰌗 ",["TypeParameter"] = "󰊄 ",["Variable"] = "󰆧 "},["lsp"] = {["auto_attach"] = true},["mappings"] = {["0"] = actions.root(),["<C-s>"] = actions.hsplit(),["<C-v>"] = actions.vsplit(),["<enter>"] = actions.select(),["<esc>"] = actions.close(),["A"] = actions.append_scope(),["F"] = actions.fold_delete(),["I"] = actions.insert_scope(),["J"] = actions.move_down(),["K"] = actions.move_up(),["V"] = actions.visual_scope(),["Y"] = actions.yank_scope(),["a"] = actions.append_name(),["c"] = actions.comment(),["d"] = actions.delete(),["f"] = actions.fold_create(),["g?"] = actions.help(),["h"] = actions.parent(),["i"] = actions.insert_name(),["j"] = actions.next_sibling(),["k"] = actions.previous_sibling(),["l"] = actions.children(),["r"] = actions.rename(),["s"] = actions.toggle_preview(),["t"] = actions.telescope({
  layout_strategy = "horizontal",
  layout_config = {
    height = 0.60,
    width = 0.75,
    prompt_position = "top",
    preview_width = 0.50
  },
}),["v"] = actions.visual_name(),["y"] = actions.yank_name()},["node_markers"] = {["enable"] = false,["icons"] = {["branch"] = " ",["leaf"] = "  ",["leaf_selected"] = " → "}},["source_buffer"] = {["followNode"] = true,["highlight"] = true,["reorient"] = "smart"},["useDefaultMappings"] = true,["window"] = {["border"] = "rounded",["sections"] = {["left"] = {["border"] = "rounded"},["mid"] = {["border"] = "rounded"},["right"] = {["border"] = "rounded",["preview"] = "leaf"}}}}



-- SECTION: clang-lsp
local clangd_cap = capabilities
-- use same offsetEncoding as null-ls
clangd_cap.offsetEncoding = {"utf-16"}
lspconfig.clangd.setup{
  capabilities = clangd_cap;
  on_attach=default_on_attach;
  cmd = { "/nix/store/pbmrmr3risgbc863qcr5lxzyd7rbfndi-clang-tools-19.1.7/bin/clangd" };
  
}


-- SECTION: codewindow
local codewindow = require('codewindow')
codewindow.setup({
  exclude_filetypes = { 'NvimTree', 'orgagenda', 'Alpha'},
})


-- SECTION: colorizer
require('colorizer').setup({["filetypes"] = {},["user_default_options"] = {}})


-- SECTION: conform-nvim
require("conform").setup({["default_format_opts"] = {["lsp_format"] = "fallback"},["format_after_save"] = function()
  if not vim.g.formatsave or vim.b.disableFormatSave then
    return
  else
    return {["lsp_format"] = "fallback"}
  end
end
,["format_on_save"] = function()
  if not vim.g.formatsave or vim.b.disableFormatSave then
    return
  else
    return {lsp_format = "fallback", timeout_ms = 500}
  end
end
,["formatters"] = {["black"] = {["command"] = "/nix/store/s3ksxwkzzrdmldy8b19vw1vcgi58r66r-python3.13-black-25.1.0/bin/black"},["deno_fmt"] = {["command"] = "/nix/store/f4s08zhz2lrjv3b8h5wk07zw0hq6vmqx-deno-2.4.2/bin/deno"},["shfmt"] = {["command"] = "/nix/store/d6s6915z6g0lsffym2ibcb8yjxrvsav6-shfmt-3.12.0/bin/shfmt"},["stylua"] = {["command"] = "/nix/store/6qdwhmgz2ishdrpn9gj0nh4fcpyxp3ck-stylua-2.1.0/bin/stylua"}},["formatters_by_ft"] = {["lua"] = {"stylua"},["markdown"] = {"deno_fmt"},["python"] = {"black"},["sh"] = {"shfmt"}}})


-- SECTION: dashboard-nvim
require("dashboard").setup({})


-- SECTION: git-conflict
require('git-conflict').setup({["default_mappings"] = false})


-- SECTION: gitsigns
require('gitsigns').setup({})


-- SECTION: hop-nvim
require('hop').setup()


-- SECTION: image-nvim
require("img-clip").setup({})


-- SECTION: lightbulb
local nvim_lightbulb = require("nvim-lightbulb")
nvim_lightbulb.setup({})
vim.api.nvim_create_autocmd({"CursorHold","CursorHoldI"}, {
  pattern = "*",
  callback = function()
    nvim_lightbulb.update_lightbulb()
  end,
})



-- SECTION: lua-lsp
lspconfig.lua_ls.setup {
  capabilities = capabilities;
  on_attach = default_on_attach;
  cmd = {"/nix/store/qnl0cg42hcdl0rjccalbw9r6d84v39my-lua-language-server-3.15.0/bin/lua-language-server"};
}


-- SECTION: lualine
local lualine = require('lualine')
lualine.setup {["extensions"] = {"neo-tree",{["filetypes"] = {"snacks_picker_list","snacks_picker_input"},["sections"] = {["lualine_a"] = {
  function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  end,
}
}}},["inactive_sections"] = {["lualine_a"] = {},["lualine_b"] = {},["lualine_c"] = {'filename'},["lualine_x"] = {'location'},["lualine_y"] = {},["lualine_z"] = {}},["options"] = {["always_divide_middle"] = true,["component_separators"] = {["left"] = "",["right"] = ""},["globalstatus"] = true,["icons_enabled"] = true,["refresh"] = {["statusline"] = 1000,["tabline"] = 1000,["winbar"] = 1000},["section_separators"] = {["left"] = "",["right"] = ""},["theme"] = "github_dark_high_contrast"},["sections"] = {["lualine_a"] = {{
  "mode",
  icons_enabled = true,
  separator = {
    left = '▎',
    right = ''
  },
}
,{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
},["lualine_b"] = {{
  "filetype",
  colored = true,
  icon_only = true,
  icon = { align = 'left' }
}
,{
  "filename",
  symbols = {modified = ' ', readonly = ' '},
  separator = {right = ''}
}
,{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
},["lualine_c"] = {{
  "diff",
  colored = false,
  diff_color = {
    -- Same color values as the general color option can be used here.
    added    = 'DiffAdd',    -- Changes the diff's added color
    modified = 'DiffChange', -- Changes the diff's modified color
    removed  = 'DiffDelete', -- Changes the diff's removed color you
  },
  symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the diff symbols
  separator = {right = ''}
}
},["lualine_x"] = {{
  -- Lsp server name
  function()
    local buf_ft = vim.bo.filetype
    local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

    if excluded_buf_ft[buf_ft] then
      return ""
      end

    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if vim.tbl_isempty(clients) then
      return "No Active LSP"
    end

    local active_clients = {}
    for _, client in ipairs(clients) do
      table.insert(active_clients, client.name)
    end

    return table.concat(active_clients, ", ")
  end,
  icon = ' ',
  separator = {left = ''},
}
,{
  "diagnostics",
  sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
  symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
  colored = true,
  update_in_insert = false,
  always_visible = false,
  diagnostics_color = {
    color_error = { fg = 'red' },
    color_warn = { fg = 'yellow' },
    color_info = { fg = 'cyan' },
  },
}
},["lualine_y"] = {{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
,{
  'searchcount',
  maxcount = 999,
  timeout = 120,
  separator = {left = ''}
}
,{
  "branch",
  icon = ' •',
  separator = {left = ''}
}
},["lualine_z"] = {{
  "",
  draw_empty = true,
  separator = { left = '', right = '' }
}
,{
  "progress",
  separator = {left = ''}
}
,{"location"}
,{
  "fileformat",
  color = {fg='black'},
  symbols = {
    unix = '', -- e712
    dos = '',  -- e70f
    mac = '',  -- e711
  }
}
}},["winbar"] = {["lualine_c"] = {{"navic",draw_empty = true}}}}


-- SECTION: markdown-lsp
lspconfig.marksman.setup{
  capabilities = capabilities;
  on_attach = default_on_attach;
  cmd = {"/nix/store/bg33jk6f1chbr59v1y39mw2pgx1l3i9g-marksman-2024-12-18/bin/marksman", "server"},
}


-- SECTION: mind-nvim
require'mind'.setup()


-- SECTION: mini-notify
require("mini.notify").setup({["window"] = {["config"] = {["border"] = "rounded"}}})
vim.notify = MiniNotify.make_notify({["DEBUG"] = {["duration"] = 0,["hl_group"] = "DiagnosticHint"},["ERROR"] = {["duration"] = 5000,["hl_group"] = "DiagnosticError"},["INFO"] = {["duration"] = 5000,["hl_group"] = "DiagnosticInfo"},["OFF"] = {["duration"] = 0,["hl_group"] = "MiniNotifyNormal"},["TRACE"] = {["duration"] = 0,["hl_group"] = "DiagnosticOk"},["WARN"] = {["duration"] = 5000,["hl_group"] = "DiagnosticWarn"}})


-- SECTION: neo-tree
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("load_neo_tree", {}),
  desc = "Loads neo-tree when opening a directory",
  callback = function(args)
    local stats = vim.uv.fs_stat(args.file)

    if not stats or stats.type ~= "directory" then
      return
    end

    require("lz.n").trigger_load("neo-tree-nvim")

    return true
  end,
})


-- SECTION: nix-lsp
lspconfig.nil_ls.setup{
  capabilities = capabilities,
on_attach = default_on_attach,
  cmd = {"/nix/store/59j5x6chkvrihb9xjaz7p0ybmyigdwsa-nil-2025-06-13/bin/nil"},
settings = {
  ["nil"] = {
formatting = {
  command = {"/nix/store/rk7b4ldkp4ssblpsa1x56kl8xf94kd1a-alejandra-4.0.0/bin/alejandra", "--quiet"},
},


  },
},

}


-- SECTION: noice-nvim
require("noice").setup({["format"] = {["cmdline"] = {["icon"] = "",["lang"] = "vim",["pattern"] = "^:"},["filter"] = {["icon"] = "",["lang"] = "bash",["pattern"] = "^:%s*!"},["help"] = {["icon"] = "󰋖",["pattern"] = "^:%s*he?l?p?%s+"},["lua"] = {["icon"] = "",["lang"] = "lua",["pattern"] = "^:%s*lua%s+"},["search_down"] = {["icon"] = " ",["kind"] = "search",["lang"] = "regex",["pattern"] = "^/"},["search_up"] = {["icon"] = " ",["kind"] = "search",["lang"] = "regex",["pattern"] = "^%?"}},["lsp"] = {["override"] = {["cmp.entry.get_documentation"] = false,["vim.lsp.util.convert_input_to_markdown_lines"] = true,["vim.lsp.util.stylize_markdown"] = true},["signature"] = {["enabled"] = false}},["presets"] = {["bottom_search"] = true,["command_palette"] = true,["inc_rename"] = false,["long_message_to_split"] = true,["lsp_doc_border"] = true},["routes"] = {{["filter"] = {["event"] = "msg_show",["find"] = "written",["kind"] = ""},["opts"] = {["skip"] = true}}}})


-- SECTION: null_ls
require('null-ls').setup({["debounce"] = 250,["debug"] = false,["default_timeout"] = 5000,["diagnostics_format"] = "[#{m}] #{s} (#{c})",["on_attach"] = on_attach,["sources"] = {require("null-ls").builtins.code_actions.gitsigns
}})


-- SECTION: nvim-biscuits
require('nvim-biscuits').setup({})


-- SECTION: nvim-docs-view
require("docs-view").setup {["height"] = 10,["position"] = "bottom",["update_mode"] = "auto",["width"] = 15}


-- SECTION: nvim-lint
require("lint").linters_by_ft = {["lua"] = {"luacheck"},["markdown"] = {"markdownlint-cli2"},["nix"] = {"statix","deadnix"},["sh"] = {"shellcheck"}}

local linters = require("lint").linters
local nvf_linters = {["deadnix"] = {["cmd"] = "/nix/store/dxfynkzb750721g2fql3c637sq6y0xk5-deadnix-1.2.1/bin/deadnix"},["luacheck"] = {["cmd"] = "/nix/store/nshc855a61kh9bp6scg5jzrhv3g6zgkx-luajit2.1-luacheck-1.2.0-1/bin/luacheck"},["markdownlint-cli2"] = {["cmd"] = "/nix/store/b9mmdi9pw8h2q0ygyr7cx573zcc3mdxa-markdownlint-cli2-0.18.1/bin/markdownlint-cli2"},["shellcheck"] = {["cmd"] = "/nix/store/c12rn8kf0w0wly8558lmr91avy1g4vi3-shellcheck-0.10.0-bin/bin/shellcheck"},["statix"] = {["cmd"] = "/nix/store/rhsxgiymhyn6km2gqv8bzj59pfnih072-statix-0.5.8/bin/statix"}}
for linter, config in pairs(nvf_linters) do
  if linters[linter] == nil then
    linters[linter] = config
  else
    for key, val in pairs(config) do
      linters[linter][key] = val
    end
  end
end

nvf_lint = function(buf)
  local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
  local linters = require("lint").linters
  local linters_from_ft = require("lint").linters_by_ft[ft]

  -- if no linter is configured for this filetype, stops linting
  if linters_from_ft == nil then return end

  for _, name in ipairs(linters_from_ft) do
    local linter = linters[name]
    assert(linter, 'Linter with name `' .. name .. '` not available')

    if type(linter) == "function" then
      linter = linter()
    end
    -- for require("lint").lint() to work, linter.name must be set
    linter.name = linter.name or name
    local cwd = linter.required_files

    -- if no configuration files are configured, lint
    if cwd == nil then
      require("lint").lint(linter)
    else
      -- if configuration files are configured and present in the project, lint
      for _, fn in ipairs(cwd) do
        local path = vim.fs.joinpath(linter.cwd or vim.fn.getcwd(), fn);
        if vim.uv.fs_stat(path) then
          require("lint").lint(linter)
          break
        end
      end
    end
  end
end



-- SECTION: nvim-web-devicons
require("nvim-web-devicons").setup({["color_icons"] = true,["override"] = {}})


-- SECTION: nvimBufferline
require("bufferline").setup({["highlights"] = {},["options"] = {["always_show_bufferline"] = true,["auto_toggle_bufferline"] = true,["buffer_close_icon"] = " 󰅖 ",["close_command"] = function(bufnum)
  require("bufdelete").bufdelete(bufnum, false)
end
,["close_icon"] = "  ",["color_icons"] = true,["diagnostics"] = "nvim_lsp",["diagnostics_indicator"] = function(count, level, diagnostics_dict, context)
  local s = " "
    for e, n in pairs(diagnostics_dict) do
      local sym = e == "error" and "   "
        or (e == "warning" and "   " or "  " )
      s = s .. n .. sym
    end
  return s
end
,["diagnostics_update_in_insert"] = false,["duplicates_across_groups"] = true,["enforce_regular_tabs"] = false,["hover"] = {["delay"] = 200,["enabled"] = true,["reveal"] = {"close"}},["indicator"] = {["style"] = "underline"},["left_mouse_command"] = "buffer %d",["left_trunc_marker"] = "",["max_name_length"] = 18,["max_prefix_length"] = 15,["mode"] = "buffers",["modified_icon"] = "● ",["move_wraps_at_ends"] = false,["numbers"] = function(opts)
  return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
end
,["offsets"] = {{["filetype"] = "NvimTree",["highlight"] = "Directory",["separator"] = true,["text"] = "File Explorer"},{["filetype"] = "neo-tree",["highlight"] = "Directory",["separator"] = true,["text"] = "File Explorer"},{["filetype"] = "snacks_layout_box",["highlight"] = "Directory",["separator"] = true,["text"] = "File Explorer"}},["persist_buffer_sort"] = true,["right_mouse_command"] = "vertical sbuffer %d",["right_trunc_marker"] = "",["separator_style"] = "thin",["show_buffer_close_icons"] = true,["show_buffer_icons"] = true,["show_close_icon"] = true,["show_duplicate_prefix"] = true,["show_tab_indicators"] = true,["sort_by"] = "extension",["style_preset"] = require('bufferline').style_preset.default,["tab_size"] = 18,["themable"] = true,["truncate_names"] = true}})


-- SECTION: otter-nvim
-- Enable otter diagnostics viewer
require("otter").setup({["buffers"] = {["write_to_disk"] = false},["handle_leading_whitespace"] = false,["lsp"] = {["diagnostic_update_event"] = {"BufWritePost"}},["strip_wrapping_quote_characters"] = {"'","\"","`"}})


-- SECTION: project-nvim
require('project_nvim').setup({["detection_methods"] = {"lsp","pattern"},["exclude_dirs"] = {},["lsp_ignored"] = {},["manual_mode"] = true,["patterns"] = {".git","_darcs",".hg",".bzr",".svn","Makefile","package.json","flake.nix","cargo.toml"},["scope_chdir"] = "global",["show_hidden"] = false,["silent_chdir"] = true})


-- SECTION: python-lsp
lspconfig.basedpyright.setup{
  capabilities = capabilities;
  on_attach = default_on_attach;
  cmd = {"/nix/store/h90ds9zp9szay7b8irhpvvh0yb45v4f1-basedpyright-1.31.0/bin/basedpyright-langserver", "--stdio"}
}


-- SECTION: smartcolumn
require("smartcolumn").setup({["colorcolumn"] = "120",["custom_colorcolumn"] = {},["disabled_filetypes"] = {"help","text","markdown","NvimTree","alpha"}})


-- SECTION: snacks-nvim
require("snacks").setup({["bigfile"] = {["enabled"] = true,["line_length"] = 1000,["notify"] = true,["size"] = 1572864.000000},["scroll"] = {["animate"] = {["duration"] = {["step"] = 15,["total"] = 250},["easing"] = "linear"},["animate_repeat"] = {["delay"] = 100,["duration"] = {["step"] = 5,["total"] = 50},["easing"] = "linear"}},["toggle"] = {["color"] = {["disabled"] = "yellow",["enabled"] = "green"},["icon"] = {["disabled"] = " ",["enabled"] = " "},["notify"] = true,["which_key"] = true,["wk_desc"] = {["disabled"] = "Enable ",["enabled"] = "Disable "}}});


-- SECTION: todo-comments
require('todo-comments').setup({["highlight"] = {["pattern"] = ".*<(KEYWORDS)(\\([^\\)]*\\))?:"},["search"] = {["args"] = {"--color=never","--no-heading","--with-filename","--line-number","--column"},["command"] = "/nix/store/1ijacjhy42pqx7vfi5mnsqrps2k3b8xf-ripgrep-14.1.1/bin/rg",["pattern"] = "\\b(KEYWORDS)(\\([^\\)]*\\))?:"}})


-- SECTION: treesitter
require('nvim-treesitter.configs').setup {
  -- Disable imperative treesitter options that would attempt to fetch
  -- grammars into the read-only Nix store. To add additional grammars here
  -- you must use the `config.vim.treesitter.grammars` option.
  auto_install = false,
  sync_install = false,
  ensure_installed = {},

  -- Indentation module for Treesitter
  indent = {
    enable = true,
    disable = {},
  },

  -- Highlight module for Treesitter
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },

  -- Indentation module for Treesitter
  -- Keymaps are set to false here as they are
  -- handled by `vim.maps` entries calling lua
  -- functions achieving the same functionality.
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = false,
      node_incremental = false,
      scope_incremental = false,
      node_decremental = false,

    },
  },
}


-- SECTION: treesitter-context
require("treesitter-context").setup({["line_numbers"] = true,["max_lines"] = 0,["min_window_height"] = 0,["mode"] = "cursor",["multiline_threshold"] = 20,["separator"] = "-",["trim_scope"] = "outer",["zindex"] = 20})


-- SECTION: vim-illuminate
require('illuminate').configure({["filetypes_denylist"] = {"dirvish","fugitive","help","neo-tree","notify","NvimTree","TelescopePrompt"}})


-- SECTION: whichkey
local wk = require("which-key")
wk.setup ({["notify"] = true,["preset"] = "modern",["replace"] = {["<cr>"] = "RETURN",["<leader>"] = "SPACE",["<space>"] = "SPACE",["<tab>"] = "TAB"},["win"] = {["border"] = "none"}})
wk.add({{{ '<leader>b', desc = '+Buffer' }},{{ '<leader>bm', desc = 'BufferLineMove' }},{{ '<leader>bs', desc = 'BufferLineSort' }},{{ '<leader>bsi', desc = 'BufferLineSortById' }},{{ '<leader>c', desc = 'Code' }},{{ '<leader>cG', desc = 'Git Diff' }},{{ '<leader>cg', desc = 'Go to' }},{{ '<leader>cw', desc = 'Workspaces' }},{{ '<leader>f', desc = '+Telescope' }},{{ '<leader>fl', desc = 'Telescope LSP' }},{{ '<leader>fm', desc = 'Cellular Automaton' }},{{ '<leader>fv', desc = 'Telescope Git' }},{{ '<leader>fvc', desc = 'Commits' }},{{ '<leader>gS', desc = 'GitSigns' }},{},{{ '<leader>lw', desc = '+Workspace' }},{{ '<leader>m', desc = '+Minimap' }},{{ '<leader>o', desc = '+Notes' }},{{ '<leader>s', desc = '+Leap' }},{{ '<leader>t', desc = 'Trouble' }},{{ '<leader>u', desc = 'ui' }},{}})




-- SECTION: augroups
local nvf_autogroups = {}
for _, group in ipairs({{["clear"] = true,["enable"] = true,["name"] = "nvf_nvim_lint"},{["clear"] = true,["enable"] = true,["name"] = "nvf_lazy_file_hooks"},{["clear"] = true,["enable"] = true,["name"] = "nvf_lsp"}}) do
  if group.name then
    nvf_autogroups[group.name] = { clear = group.clear }
  end
end

for group_name, options in pairs(nvf_autogroups) do
  vim.api.nvim_create_augroup(group_name, options)
end


-- SECTION: autocmds
local nvf_autocommands = {{["callback"] = function(args)
  nvf_lint(args.buf)
end
,["enable"] = true,["event"] = {"BufWritePost"},["nested"] = false,["once"] = false},{["command"] = "doautocmd User LazyFile",["enable"] = true,["event"] = {"BufReadPost","BufNewFile","BufWritePre"},["group"] = "nvf_lazy_file_hooks",["nested"] = false,["once"] = true}}
for _, autocmd in ipairs(nvf_autocommands) do
  vim.api.nvim_create_autocmd(
    autocmd.event,
    {
      group     = autocmd.group,
      pattern   = autocmd.pattern,
      buffer    = autocmd.buffer,
      desc      = autocmd.desc,
      callback  = autocmd.callback,
      command   = autocmd.command,
      once      = autocmd.once,
      nested    = autocmd.nested
    }
  )
end


-- SECTION: diagnostics
vim.diagnostic.config({["signs"] = false,["underline"] = true,["update_in_insert"] = false,["virtual_line"] = {["enable"] = true},["virtual_lines"] = false,["virtual_text"] = false})



-- SECTION: lsp-servers
-- Individual LSP configurations managed by nvf.
vim.lsp.config["*"] = {["capabilities"] = capabilities,["enable"] = true,["on_attach"] = default_on_attach}



-- Enable configured LSPs explicitly
vim.lsp.enable({})


-- SECTION: mappings
vim.keymap.set({"n"}, "<leader>bc", ":BufferLinePick<CR>", {["desc"] = "Pick buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bmn", ":BufferLineMoveNext<CR>", {["desc"] = "Move next buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bmp", ":BufferLineMovePrev<CR>", {["desc"] = "Move previous buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bn", ":BufferLineCycleNext<CR>", {["desc"] = "Next buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bp", ":BufferLineCyclePrev<CR>", {["desc"] = "Previous buffer",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bsd", ":BufferLineSortByDirectory<CR>", {["desc"] = "Sort buffers by directory",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bse", ":BufferLineSortByExtension<CR>", {["desc"] = "Sort buffers by extension",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>bsi", function() require("bufferline").sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end) end, {["desc"] = "Sort buffers by ID",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>c0", "<Plug>(git-conflict-none)", {["desc"] = "Choose None [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>cb", "<Plug>(git-conflict-both)", {["desc"] = "Choose Both [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>co", "<Plug>(git-conflict-ours)", {["desc"] = "Choose Ours [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>ct", "<Plug>(git-conflict-theirs)", {["desc"] = "Choose Theirs [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>h", "<cmd> HopPattern<CR>", {["desc"] = "Jump to occurrences [hop.nvim]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hD", function() package.loaded.gitsigns.diffthis('~') end, {["desc"] = "Diff project [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hP", package.loaded.gitsigns.preview_hunk, {["desc"] = "Preview hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hR", package.loaded.gitsigns.reset_buffer, {["desc"] = "Reset buffer [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hS", package.loaded.gitsigns.stage_buffer, {["desc"] = "Stage buffer [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hb", function() package.loaded.gitsigns.blame_line{full=true} end, {["desc"] = "Blame line [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hd", package.loaded.gitsigns.diffthis, {["desc"] = "Diff this [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hr", package.loaded.gitsigns.reset_hunk, {["desc"] = "Reset hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hs", package.loaded.gitsigns.stage_hunk, {["desc"] = "Stage hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>hu", package.loaded.gitsigns.undo_stage_hunk, {["desc"] = "Undo stage hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>lo", "<cmd>lua require'otter'.activate()<CR>", {["desc"] = "Activate LSP on Cursor Position [otter-nvim]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>lvt", "<cmd>DocsViewToggle<CR>", {["desc"] = "Open or close the docs view panel",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>lvu", "<cmd>DocsViewUpdate<CR>", {["desc"] = "Manually update the docs view panel",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>mc", require('codewindow').close_minimap, {["desc"] = "Close minimap [codewindow]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>mf", require('codewindow').toggle_focus, {["desc"] = "Toggle minimap focus [codewindow]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>mm", require('codewindow').toggle_minimap, {["desc"] = "Toggle minimap [codewindow]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>mo", require('codewindow').open_minimap, {["desc"] = "Open minimap [codewindow]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>oc", ":MindClose<CR>", {["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>om", ":MindOpenMain<CR>", {["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>op", ":MindOpenProject<CR>", {["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>tb", package.loaded.gitsigns.toggle_current_line_blame, {["desc"] = "Toggle blame [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>td", package.loaded.gitsigns.toggle_deleted, {["desc"] = "Toggle deleted [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>tdq", ":TodoQuickFix<CR>", {["desc"] = "Open Todo-s in a quickfix list",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>tds", ":TodoTelescope<CR>", {["desc"] = "Open Todo-s in telescope",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>tdt", ":TodoTrouble<CR>", {["desc"] = "Open Todo-s in Trouble",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "[c", function()
  if vim.wo.diff then return "[c" end

  vim.schedule(function() package.loaded.gitsigns.prev_hunk() end)

  return '<Ignore>'
end
, {["desc"] = "Previous hunk [Gitsigns]",["expr"] = true,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "[x", "<Plug>(git-conflict-next-conflict)", {["desc"] = "Go to the next Conflict [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "]c", function()
  if vim.wo.diff then return "]c" end

  vim.schedule(function() package.loaded.gitsigns.next_hunk() end)

  return '<Ignore>'
end
, {["desc"] = "Next hunk [Gitsigns]",["expr"] = true,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "]x", "<Plug>(git-conflict-prev-conflict)", {["desc"] = "Go to the previous Conflict [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "gnn", ":lua require('nvim-treesitter.incremental_selection').init_selection()<CR>", {["desc"] = "Init selection [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, "<leader>hr", function() package.loaded.gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {["desc"] = "Reset hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, "<leader>hs", function() package.loaded.gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {["desc"] = "Stage hunk [Gitsigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n","x"}, "grc", "<cmd>lua require('nvim-treesitter.incremental_selection').scope_incremental()<CR>", {["desc"] = "Increment selection by scope [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n","x"}, "grm", "<cmd>lua require('nvim-treesitter.incremental_selection').node_decremental()<CR>", {["desc"] = "Decrement selection by node [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n","x"}, "grn", "<cmd>lua require('nvim-treesitter.incremental_selection').node_incremental()<CR>", {["desc"] = "Increment selection by node [treesitter]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<leader>ff", ":Telescope find_files<CR>", {["desc"] = "Find files [Telescope]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>fg", ":Telescope live_grep<CR>", {["desc"] = "Live grep [Telescope]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>fb", ":Telescope buffers<CR>", {["desc"] = "List buffers [Telescope]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>fh", ":Telescope help_tags<CR>", {["desc"] = "Help tags [Telescope]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>fr", ":Telescope oldfiles<CR>", {["desc"] = "Recent files [Telescope]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>fe", ":Neotree toggle<CR>", {["desc"] = "Toggle file tree [Neotree]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>fE", ":Neotree float<CR>", {["desc"] = "Open file tree in float [Neotree]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "[c", ":Gitsigns prev_hunk<CR>", {["desc"] = "Prev hunk",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "]c", ":Gitsigns next_hunk<CR>", {["desc"] = "Next hunk",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>gSs", ":Gitsigns stage_hunk<CR>", {["desc"] = "Stage hunk [GitSigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>gSr", ":Gitsigns reset_hunk<CR>", {["desc"] = "Reset hunk [GitSigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>gSp", ":Gitsigns preview_hunk<CR>", {["desc"] = "Preview hunk [GitSigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>gSb", ":Gitsigns blame_line<CR>", {["desc"] = "Blame line [GitSigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>gSd", ":Gitsigns diffthis<CR>", {["desc"] = "Diff this [GitSigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>gSu", ":Gitsigns undo_stage_hunk<CR>", {["desc"] = "Undo Stage Hunk [GitSigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>gSt", ":Gitsigns toggle_current_line_blame<CR>", {["desc"] = "Toggle Current Line Blame[GitSigns]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>tx", ":Trouble<CR>", {["desc"] = " Trouble Cmd List [Trouble]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>tD", ":Trouble diagnostics<CR>", {["desc"] = "Document diagnostics [Trouble]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>tl", ":Trouble loclist<CR>", {["desc"] = "LOC List [Trouble]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>tq", ":Trouble quickfix<CR>", {["desc"] = "Quickfix list [Trouble]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>ts", ":Trouble symbols<CR>", {["desc"] = "Symbols List [Trouble]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>/", ":ToggleTerm<CR>", {["desc"] = "Toggle Terminal [Toggle Term]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"t"}, "<Leader>/", "<C-\\><C-n>:ToggleTerm<CR>", {["desc"] = "Toggle Terminal [Toggle Term]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cd", ":DocsViewToggle", {["desc"] = "Toggle Docs View [nvim-docs-view]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>ca", "vim.lsp.buf.code_action", {["desc"] = "Code Action [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cf", "vim.lsp.buf.format", {["desc"] = "Code Format [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cn", "vim.lsp.buf.rename", {["desc"] = "Code Rename [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cp", "vim.lsp.buf.signature_help", {["desc"] = "Signature Help [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cS", "vim.lsp.buf.document_symbol", {["desc"] = "List Document Symbols [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cgD", "vim.lsp.buf.declaration", {["desc"] = "Go to declaration [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cgd", "vim.lsp.buf.definition", {["desc"] = "Go to definition [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cgt", "vim.lsp.buf.type_defintion", {["desc"] = "Go to type[LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cgi", "vim.lsp.buf.implementation", {["desc"] = "Go to implementation[LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cgr", "vim.lsp.buf.references", {["desc"] = "List References [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cgn", "vim.diagnostics.goto_next", {["desc"] = "Go to next diagnostics [Diagnostic]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cgp", "vim.diagnostics.goto_prev", {["desc"] = "Go to prev diagnostics [Diagnostic]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>ce", "vim.diagnostics.open_float", {["desc"] = "Open diagnostic float [Diagnostic]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>ch", "vim.lsp.buf.hover", {["desc"] = "Trigger Hover [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cH", "vim.lsp.buf.document_highlight", {["desc"] = "Document Highlight [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cwa", "vim.lsp.buf.add_workspace_folder", {["desc"] = "Add workspace folder [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cwr", "vim.lsp.buf.remove_workspace_folder", {["desc"] = "Remove workspace folder [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cwl", "function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end", {["desc"] = "List workspace folders [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cws", "vim.lsp.buf.workplace_symbol", {["desc"] = "List workspace symbols [LSP]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cGd0", "<Plug>(git-conflict-none)", {["desc"] = "Choose None [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cGdb", "<Plug>(git-conflict-both)", {["desc"] = "Choose Both [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cGdo", "<Plug>(git-conflict-ours)", {["desc"] = "Choose Ours [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"n"}, "<Leader>cGdt", "<Plug>(git-conflict-theirs)", {["desc"] = "Choose Theirs [Git-Conflict]",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"i"}, "jk", "<ESC>", {["desc"] = "Exit insert mode",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, "J", ":m '>+1<CR>gv=gv", {["desc"] = "",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, "K", ":m '<-2<cr>gv=gv", {["desc"] = "",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"x"}, "<leader>p", "'_dP", {["desc"] = "",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, "<", "<gv", {["desc"] = "",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})
vim.keymap.set({"v"}, ">", ">gv", {["desc"] = "",["expr"] = false,["noremap"] = true,["nowait"] = false,["script"] = false,["silent"] = true,["unique"] = false})


-- SECTION: precognition
require('precognition').setup({["disabled_fts"] = {"startify"},["gutterHints"] = {},["highlightColor"] = {["link"] = "Comment"},["hints"] = {},["showBlankVirtLine"] = true,["startVisible"] = true})


-- SECTION: spellcheck
-- Disable spellchecking for certain filetypes
-- as configured by `vim.spellcheck.ignoredFiletypes`
vim.api.nvim_create_augroup("nvf_autocmds", {clear = false})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "nvf_autocmds",
  pattern = { "toggleterm" },
  callback = function()
    vim.opt_local.spell = false
  end,
})


-- SECTION: vim-dirtytalk
-- If Neovim can find (or access) the state directory
-- then append "programming" wordlist from vim-dirtytalk
-- to spelllang table. If path cannot be found, display
-- an error and avoid appending the programming words
if vim.fn.isdirectory(vim.fn.stdpath('state')) == 1 then
  vim.opt.spelllang:append("programming")
else
  vim.notify("State path does not exist: " .. state_path, vim.log.levels.ERROR)
end


-- TODO:
-- Helper functions commands

local map = vim.keymap.set

Snacks.toggle.option("spell", { name = "Spell Checking" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap Lines" }):map("<leader>uw")
Snacks.toggle.option("list", { name = "List (Visible Whitespaces)" }):map("<leader>ul")
Snacks.toggle.diagnostics({ name = "Toggle Diagnostics" }):map("<leader>uD")
Snacks.toggle.treesitter({ name = " Treesitter Highlighting" }):map("<leader>ut")
Snacks.toggle.scroll({name = "Scroll"}):map("<leader>uS")

Snacks.toggle
.new({
  name = "Format Save",
  get = function()
    return vim.b.disableFormatSave
  end,
  set = function(state)
    vim.b.disableFormatSave = state
  end,
}):map("<leader>uf")

Snacks.toggle
  .new({
    id = "git_blame",
    name = " Git Blame",
    get = function()
      return require("gitsigns.config").config.current_line_blame
    end,
    set = function(state)
      require("gitsigns").toggle_current_line_blame(state)
    end,
}):map("<leader>ub")

Snacks.toggle
  .new({
    id = "number",
    name = " Line Numbers",
    get = function()
      return vim.wo.number
    end,
    set = function(state)
      if state then
        vim.wo.relativenumber = false
      end
      vim.wo.number = state
    end,
}):map("<leader>un")

Snacks.toggle
  .new({
    id = "relativenumber",
    name = " Relative Line Numbers",
    get = function()
      return vim.wo.relativenumber
    end,
    set = function(state)
      if state then
        vim.wo.number = false
      end
      vim.wo.relativenumber = state
    end,
  }):map("<leader>uN")


Snacks.toggle
  .new({
    id = "inline_hints",
    name = " LSP Inline Hints",
    get = vim.lsp.inlay_hint.is_enabled,
    set = function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
}):map("<leader>ui")


-- blink-cmp toggle configuration
vim.b.completion = false -- completion off by default

Snacks.toggle
  .new({
    name = "Completion",
    get = function()
      return vim.b.completion
    end,
    set = function(state)
      vim.b.completion = state
    end,
  }):map("<leader>uC")



-- Auto-update programming wordlist on first startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Check if dirtytalk dict file exists
    local dict_path = vim.fn.stdpath('data') .. '/site/spell/programming.utf-8.add'
    if vim.fn.filereadable(dict_path) == 0 then
      -- Only run if file doesn't exist to avoid repeated downloads
      vim.schedule(function()
        vim.cmd('DirtytalkUpdate')
      end)
    end
  end,
})

-- Remove keybinds that we rebinded so that they dont show up in which-key
-- No clue?
vim.keymap.del("n", "<leader>fm")

-- Gitsigns
vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>hb")
vim.keymap.del("n", "<leader>hd")
vim.keymap.del("n", "<leader>hD")
vim.keymap.del("n", "<leader>hP")
vim.keymap.del("n", "<leader>hr")
vim.keymap.del("n", "<leader>hR")
vim.keymap.del("n", "<leader>hs")
vim.keymap.del("n", "<leader>hS")
vim.keymap.del("n", "<leader>hu")
vim.keymap.del("n", "<leader>tb")
vim.keymap.del("n", "<leader>td")

-- Trouble
vim.keymap.del("n", "<leader>xl")
vim.keymap.del("n", "<leader>xq")
vim.keymap.del("n", "<leader>xs")

-- NOTE: Code
-- code action
vim.keymap.del("n", "<leader>la")
-- code format
vim.keymap.del("n", "<leader>lf")
-- format save
vim.keymap.del("n", "<leader>ltf")
-- Signature help
vim.keymap.del("n", "<leader>ls")
-- Trigger Hover
vim.keymap.del("n", "<leader>lh")
-- Document Highlight
vim.keymap.del("n", "<leader>lH")

-- LSP goto
vim.keymap.del("n", "<leader>lgd")
vim.keymap.del("n", "<leader>lgD")
vim.keymap.del("n", "<leader>lgt")
vim.keymap.del("n", "<leader>lgi")
vim.keymap.del("n", "<leader>lgr")
vim.keymap.del("n", "<leader>lgp")
vim.keymap.del("n", "<leader>lgn")

-- diagnostic float
vim.keymap.del("n", "<leader>le")

-- workspace
vim.keymap.del("n", "<leader>lwa")
vim.keymap.del("n", "<leader>lwr")
vim.keymap.del("n", "<leader>lwl")
vim.keymap.del("n", "<leader>lws")
vim.keymap.del("n", "<leader>lwd")

-- otter lsp
vim.keymap.del("n", "<leader>lo")

-- code - git diff
vim.keymap.del("n", "<leader>c0")
vim.keymap.del("n", "<leader>cb")
vim.keymap.del("n", "<leader>co")
vim.keymap.del("n", "<leader>ct")











