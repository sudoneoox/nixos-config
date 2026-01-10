# NOTE: Theming is handled by wallust
{
  custom,
  pkgs,
  lib,
  ...
}: let
  x = custom.x0;
  nixGL =
    if (x.system.hostProfile == "laptop")
    then lib.getExe pkgs.nixgl.auto.nixGLDefault
    else lib.getExe pkgs.nixgl.auto.nixGLDefault;
  wrappedKitty = pkgs.writeShellScriptBin "kitty" ''
    exec ${nixGL} ${pkgs.kitty}/bin/kitty "$@"
  '';
in {
  imports = [
    ./fonts.nix
    ./settings.nix
    ./bindings.nix
    ./extra.nix
    ./integration.nix
    ./files.nix
  ];

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    package =
      if x.derived.isArch
      then wrappedKitty
      else pkgs.kitty;
  };
}
