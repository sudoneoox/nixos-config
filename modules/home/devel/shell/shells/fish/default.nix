{
  imports = [
    ./binds.nix
    ./fishFunctions.nix
    ./interactiveShellInit.nix
    ./plugins.nix
    ./shellAbbrs.nix
    ./shellAliases.nix
    ./shellInit.nix
  ];
  programs.fish = {
    enable = true;
    generateCompletions = true;
  };
}
