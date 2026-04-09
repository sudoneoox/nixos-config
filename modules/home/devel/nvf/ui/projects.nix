{
  programs.nvf.settings.vim.projects."project-nvim" = {
    enable = true;
    setupOpts = {
      manual_mode = true;
      patterns = [".git" "flake.nix" "package.json"];
      show_hidden = false;
    };
  };
}
