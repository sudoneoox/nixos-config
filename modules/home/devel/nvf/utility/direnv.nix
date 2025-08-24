{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = {
    direnv-vim = {
      package = pkgs.vimPlugins.direnv-vim;

      # Minimal, safe “just work” setup
      setup = ''
        -- On start + when you cd, sync $ENV from direnv if available
        local function direnv_export()
          if vim.fn.exists(':DirenvExport') == 2 then
            pcall(vim.cmd, 'silent! DirenvExport')
          end
        end

        direnv_export()
        vim.api.nvim_create_autocmd({ 'DirChanged', 'BufEnter' }, {
          callback = direnv_export,
          desc = 'Sync environment from direnv on directory change',
        })
      '';
    };
  };
}
