{ pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };


}

