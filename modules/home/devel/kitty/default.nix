{pkgs, ...}: {
  # TODO: fix ctrl+a > t key bind
  # by either making a script for it to rename the generated file to current-theme.conf
  # supplying a default current-theme.conf and dont symlink it with HM
  imports = [
    ./fonts.nix
    ./settings.nix
    ./bindings.nix
    ./extra.nix
    ./integration.nix
    ./theme.nix
    ./files.nix
  ];

  home.packages = [
    pkgs.kitty-themes
  ];

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
  };
}
