{
  programs.nvf.settings.vim = {
    # ── Aliases / Core opts ────────────────────────────────────────────────────
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    enableLuaLoader = true;
    preventJunkFiles = true;
    options = {
      # Line Numbers
      relativenumber = true;
      number = true;
      ruler = true;

      # Line indenting
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      wrap = false;

      # Cursor Line
      cursorline = true;

      # Search Settings
      termguicolors = true;
      signcolumn = "yes";

      # Backspaces
      backspace = "indent,eol,start";

      # Split Window
      splitright = true;
      splitbelow = true;

      # Searching
      ignorecase = true;
      smartcase = true;
      # Command Line
      wildmenu = true;
      showcmd = true;
    };

    # ── Clipboard ──────────────────────────────────────────────────────────────
    clipboard = {
      enable = true;
      registers = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xsel.enable = true;
      };
    };
  };
}
