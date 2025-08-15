{pkgs, ...}: {
  programs.kitty.font = {
    # JetBrainsMono Nerd Font as in your conf
    package = pkgs.nerd-fonts.jetbrains-mono;
    name = "JetBrainsMono Nerd Font";
    size = 11.0;
  };
}
