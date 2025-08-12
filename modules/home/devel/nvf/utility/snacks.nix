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
      bigfile = {
        enabled = true;
        notify = true;
        size = 1.5 * 1024 * 1024; # 1.5 MB
        line_length = 1000;
      };
      scroll = {
        animate = {
          duration = {
            step = 15;
            total = 250;
          };
          easing = "linear";
        };
        animate_repeat = {
          delay = 100;
          duration = {
            step = 5;
            total = 50;
          };
          easing = "linear";
        };
      };
    };
  };
}
