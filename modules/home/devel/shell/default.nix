{pkgs, ...}: {
  imports = [
    ./shells
    ./commands
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
    age
    neofetch
    sops
    tldr
    devenv
    comma
  ];
}
