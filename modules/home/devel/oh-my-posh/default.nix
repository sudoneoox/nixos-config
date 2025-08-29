{
  imports = [./config.nix];
  programs.starship.enable = false;
  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
  };
}
