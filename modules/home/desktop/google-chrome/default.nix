{
  pkgs,
  custom,
  ...
}: let
  x = custom.x0;
in {
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    # See https://nix-community.github.io/home-manager/options.xhtml#opt-programs.chromium.extensions
    extensions = [];
  };
}
