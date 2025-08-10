{
  programs.nixvim.options = { 
    relativenumber = true;
    number = true;
    ruler = true;

    tabstop = 2;
    shiftwidth = 4;
    expandtab = true;
    autoindent = true;

    wrap = false;
    cursorline = true;

    termguicolors = true;
    background = "dark";
    signcolumn = "yes";

    backspace = "indent,eol,start";
    splitright = true;
    splitbelow = true;

    clipboard = "unnamedplus";
    wildmenu = true;
    showcmd = true;
  };
}
