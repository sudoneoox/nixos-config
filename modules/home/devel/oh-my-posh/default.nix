{
  imports = [./config.nix];
  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
  };
}
