{
  pkgs,
  config,
  ...
}: let
  x = config.x0;
in {
  programs.kitty.font = {
    #TODO: change to x.ux.defaultFont need a lib wrapper
    package = pkgs.nerd-fonts.jetbrains-mono;
    name = x.ux.font;
    size = x.ux.fontSize;
  };
}
