{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
    ./commands
    ./languages
  ];

  home.packages = with pkgs; [
    systemctl-tui
    wget
    croc
    zip
    unzip
    pciutils
    cargo

    ffmpeg
    repomix
    age
    neofetch
    sops
    tldr
    devenv
    comma
  ];
}
