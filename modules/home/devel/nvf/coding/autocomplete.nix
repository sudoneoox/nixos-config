{
  programs.nvf.settings.vim.autocomplete.blink-cmp = {
    enable = true;
    setupOpts = {
      signature.enabled = true; # TEST: remove or keep
      "completion".documentation.auto_show = true;
      "completion".documentation.auto_show_delay_ms = 200;
      "completion".menu.auto_show = true;
    };
  };
}
