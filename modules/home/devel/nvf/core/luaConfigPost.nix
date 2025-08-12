{
  programs.nvf.settings.vim.luaConfigPost = ''
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

  '';
}
