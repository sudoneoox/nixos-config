{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
    ./bat.nix
    ./lazygit.nix
    ./zoxide
    ./ripgrep.nix
    ./btop.nix
  ];

  programs = {
    go.enable = true;
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    lsd = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    grc
    systemctl-tui
    ranger
    wget
    croc
    zip
    unzip
    pciutils
    gnumake
    nvtopPackages.full
    nix-output-monitor
    dig

    python312
    python312Packages.pipx
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    cargo
    nixpkgs-fmt

    ffmpeg
    repomix
    age
    dwt1-shell-color-scripts
    neofetch
    sops
    tldr
    devenv
    jq
    grim
    comma
  ];
}
