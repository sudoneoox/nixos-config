let
  shaderDirPath = ./shaders;
  tomlConfigFile = ./hyprshade.toml;
in {
  home.file.".config/hypr/hyprshade.toml".source = tomlConfigFile;
  home.file.".config/hypr/shaders".source = shaderDirPath;
}
