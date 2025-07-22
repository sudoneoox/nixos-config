{ config, pkgs, ... }:

{
  home.file = {
    ".config/fish" = {
      recursive = true;
      source = "${pkgs.sfish}";
    };
  };

  home.packages = with pkgs;
    [
      grc
    ];


  programs.fish = {
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z; }
      { name = "nvm"; src = pkgs.fishPlugins.nvm; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf; }
      { name = "sponge"; src = pkgs.fishPlugins.sponge; }
      { name = "puffer"; src = pkgs.fishPlugins.puffer; }
      { name = "tide"; src = pkgs.fishPlugins.tide; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair; }
    ];
  };
}
