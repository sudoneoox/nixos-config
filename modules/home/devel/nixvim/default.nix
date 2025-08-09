{pkgs, inputs, ...}:
{
  # TODO: migrate nvim config to nixvim
  
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enableMan = false;
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    # allows the use of nixvim-print-init which
    # 'Installs a tool that shows the content of the generated init.lua file'
    enablePrintInit = true;
    luaLoader.enable = true;
    
  };
}
