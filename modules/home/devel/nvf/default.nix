{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./coding
    ./core
    ./debugger
    ./tools
    ./ui
    ./utility
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      enableLuaLoader = true;
    };
  };
}
