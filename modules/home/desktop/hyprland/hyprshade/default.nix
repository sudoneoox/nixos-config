let
  shaderDirPath = ./shaders;
  tomlConfigFile = ./hyprshade.toml;
in {
  xdg.configFile."/hypr/hyprshade.toml".source = tomlConfigFile;
  xdg.configFile."hypr/shaders" = {
    source = shaderDirPath;
    recursive = true;
  };
}
