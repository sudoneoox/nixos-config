{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # issues with ui/minimap and utility/editing/nvim-biscuits

    inputs.nvf.homeManagerModules.default
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
