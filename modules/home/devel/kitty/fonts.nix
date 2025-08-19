{
  pkgs,
  custom_vars,
  ...
}: {
  programs.kitty.font = {
    # JetBrainsMono Nerd Font as in your conf
    package = pkgs.nerd-fonts.jetbrains-mono;
    name = "JetBrainsMono Nerd Font";
    size = custom_vars.FONT_SIZE;
  };
}
