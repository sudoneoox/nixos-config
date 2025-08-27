{
  pkgs,
  X0,
  ...
}: {
  programs.kitty.font = {
    # JetBrainsMono Nerd Font as in your conf
    package = pkgs.nerd-fonts.jetbrains-mono;
    name = "JetBrainsMono Nerd Font";
    size = X0.FONT_SIZE;
  };
}
