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

      name = "Format Save",
      get = function()
        return not vim.b.disableFormatSave
      end,
      set = function(state)
        vim.b.disableFormatSave = not state
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
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   callback = function()
    --     -- Check if dirtytalk dict file exists
    --       local dict_path = vim.fn.stdpath('data') .. '/site/spell/programming.utf-8.add'
    --       if vim.fn.filereadable(dict_path) == 0 then
    --         -- Only run if file doesn't exist to avoid repeated downloads
    --         vim.schedule(function()
    --           vim.cmd('DirtytalkUpdate')
    --         end)
    --       end
    --   end,
    -- })

  '';
}
