{
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
