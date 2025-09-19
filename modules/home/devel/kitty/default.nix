# NOTE: Theming is handled by wallust
{
  custom,
  pkgs,
  ...
}: let
  x = custom.x0;
  wrappedKitty = pkgs.writeShellScriptBin "kitty" ''
    exec ${pkgs.nixgl.nixGLDefault}/bin/nixGL ${pkgs.kitty}/bin/kitty "$@"
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
      if x.identity.OS == "arch"
      then wrappedKitty
      else pkgs.kitty;
  };
}
