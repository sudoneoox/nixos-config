{
  imports = [./config.nix];
  programs.fireship.enable = false;
  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
  };
}
