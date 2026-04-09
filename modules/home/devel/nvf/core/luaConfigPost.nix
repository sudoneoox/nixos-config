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



    vim.lsp.inlay_hint.enable(false) -- off by default

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
    vim.b.completion = true -- completion on by default

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

    -- neopywal lualine setup
    local has_lualine, lualine = pcall(require, "lualine")
    if not has_lualine then
      return
    end

    local has_neopywal, neopywal_lualine = pcall(require, "neopywal.theme.plugins.lualine")
    if not has_neopywal then
      return
    end

    neopywal_lualine.setup()


  '';
}
