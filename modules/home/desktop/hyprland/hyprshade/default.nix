{ pkgs, ... }:
let
  shaderDirPath = ./shaders;
  tomlConfigFile = ./config.toml;
in
{

  # home.file.".config/hypr/shaders".source = shaderDirPath;
  # home.file.".config/hypr/shaders".recursive = true;
  home.file.".config/hypr/hyprshade.toml".source = tomlConfigFile;
}
