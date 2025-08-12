{
  programs.nvf.settings.vim.luaConfigPost = ''
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
