{
  programs.nvf.settings.vim.utility.snacks-nvim = {
    enable = true;
    setupOpts = {
      toggle = {
        which_key = true;
        notify = true;
        icon.enabled = " ";
        icon.disabled = " ";
        color.enabled = "green";
        color.disabled = "yellow";
        wk_desc.enabled = "Disable ";
        wk_desc.disabled = "Enable ";
      };
    };
  };
}
