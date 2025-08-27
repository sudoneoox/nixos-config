# NOTE: Theming is handled by wallust
{
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
  };
}
