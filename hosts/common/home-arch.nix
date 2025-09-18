{
  outputs,
  custom,
  inputs,
  pkgs,
  lib,
  ...
}: let
  x = custom.x0;
in {
  # Reuse the same HM module stack you use on NixOS
  imports = [
    inputs.nvf.homeManagerModules.default

    ../../modules/home/devel/git
    ../../modules/home/devel/kitty
    ../../modules/home/devel/nvf
    ../../modules/home/devel/oh-my-posh
    ../../modules/home/devel/shell
    ../../modules/home/devel/typst

    ../../modules/home/desktop/zen-browser
    ../../modules/home/desktop/nixcord
    ../../modules/home/desktop/hyprland
    ../../modules/home/desktop/cursors
    ../../modules/home/utils
  ];

  # Same nixpkgs overlay setup (works fine in HM-standalone)
  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.additions
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Fonts + theming (fine on Arch; ensure packages exist in nixpkgs)
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-black";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  # Home identity/paths (x.derived.homeDir is fine if it’s generic)
  home = {
    username = x.identity.username;
    homeDirectory = x.derived.homeDir; # or "/home/${x.identity.username}"
    stateVersion = "25.05";
  };

  # Let HM manage ~/.config and user services
  xdg.enable = true;
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nixVersions.stable; # or pkgs.nix
    settings = {
      trusted-users = ["root" "@wheel" x.identity.username];
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = true;

      # Use all cores; parallelize builds
      max-jobs = "auto";
      cores = 0;

      # Faster networking & fewer stalls
      http2 = true;
      connect-timeout = 5;
      narinfo-cache-negative-ttl = 60;

      # Smaller store & dedup
      auto-optimise-store = true;

      # Substituters
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://nyx.chaotic.cx"
        "https://nvf.cachix.org"
        "https://neovim-nightly.cachix.org"
        #NOTE: My own cachix
        "https://nixossudnox.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
        "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
        #NOTE: My own cachix
        "nixossudnox.cachix.org-1:ZwKSBOS8npDqpdX9cg7kMvEx5dOSYq05O69qm5O0mLg="
      ];

      # Don’t die if a cache is missing a build
      fallback = true;
    };
  };
  systemd.user.startServices = "sd-switch";

  # Handy CLIs a bunch of your modules assume
  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    unzip
    wl-clipboard
    xclip
    hyprland-git.hyprland
    wl-gammarelay-rs
    hyprpaper
    hyprshade
    hyprpicker
    hypridle
    hyprlock
    hyprland-smw
    waybar
    rofi
    dunst
    wl-clipboard
    grim
    slurp
    swappy
    brightnessctl
    playerctl
    pamixer
    kitty
    hyprland-git.xdg-desktop-portal-hyprland
    hyprland-plugins.hyprbars
    hy3
  ];
}
