{ ... }:
let
  shaderDirPath = ./shaders;
  tomlConfigFile = ./hyprshade.toml;
in
{

  home.file."Assets/nixos-config/shaders".source = shaderDirPath;
  home.file."Assets/nixos-config/shaders".recursive = true;
  home.file."Assets/nixos-config/shaders/hyprshade.toml".source = tomlConfigFile;
}
