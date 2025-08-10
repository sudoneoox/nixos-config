{
  programs.nixvim.plugins = {
    lualine.enable = true;
    bufferline.enable = true;
    which-key.enable = true;
  };

  imports = [
    ./telescope.nix
  ];

}
