{
  programs.kitty.shellIntegration = {
    mode = "enabled";
    #NOTE: HM will auto-enable per-shell unless disabled, but let’s be explicit:
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
