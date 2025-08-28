{
  pkgs,
  config,
  ...
}: {
  programs.kitty.font = {
    # JetBrainsMono Nerd Font as in your conf
    package = pkgs.nerd-fonts.jetbrains-mono;
    name = "JetBrainsMono Nerd Font";
    size = config.x0.fontSize;
  };
}
