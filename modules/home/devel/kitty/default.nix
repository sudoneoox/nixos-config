{
  imports = [
    ./fonts.nix
    ./settings.nix
    ./bindings.nix
    ./extra.nix
    ./integration.nix
    ./theme.nix
    ./files.nix
  ];

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
  };
}
