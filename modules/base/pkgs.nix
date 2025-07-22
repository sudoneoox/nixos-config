{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi-wayland
    fzf
    xclip

    # CMDLINE UTILS
    bat
    wget
    tree
    tldr
    curl

    # PROGRAMS
    zathura

    # DEVELOPMENT TOOLS
    git
    starship

    # BASE DEVEL LANGUAGES
    cargo
    go
    luajit

    # EXTRA
    lix

  ];
}

