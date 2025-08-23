{
  programs.nvf.settings.vim.notify.nvim-notify = {
    enable = true;
    setupOpts = {
      icons = {
        DEBUG = "";
        ERROR = "";
        INFO = "";
        TRACE = "";
        WARN = "";
      };
      position = "top_right";
      stages = "fade_in_slide_out";
      render = "compact";
      timeout = 1000;
    };
  };
}
