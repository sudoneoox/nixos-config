{
  outputs,
  inputs,
  config,
  custom,
  pkgs,
  lib,
  ...
}: let
  x = custom.x0;
in {
  imports =
    [
      ../../modules/home/devel/git
      ../../modules/home/devel/kitty
      ../../modules/home/devel/nvf
      ../../modules/home/devel/oh-my-posh
      ../../modules/home/devel/shell/shells/fish
      ../../modules/home/devel/typst
      ../../modules/home/utils/rofi
      ../../modules/home/utils/Assets
    ]
    ++ lib.optionals (x.ux.colorScheme == "wallust")
    [
      ../../modules/home/utils/wallust
    ];

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.additions
      inputs.nixgl.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  fonts.fontconfig.enable = true;

  home = {
    username = x.identity.username;
    homeDirectory = x.derived.homeDir;
    stateVersion = "25.05";
  };

  # Let HM manage ~/.config and user services
  xdg.enable = true;
  programs.home-manager.enable = true;

  programs.nh = {
    enable = true;
    clean = {
      enable = !config.nix.gc.automatic;
      dates = "weekly";
      extraArgs = "--keep 10";
    };
    flake = x.nixosConfPath;
  };

  nix = {
    package = pkgs.lixPackageSets.git.lix;
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
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://nyx.chaotic.cx"
        "https://nvf.cachix.org"
        "https://neovim-nightly.cachix.org"
        "https://nixossudnox.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
        "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
        "nixossudnox.cachix.org-1:ZwKSBOS8npDqpdX9cg7kMvEx5dOSYq05O69qm5O0mLg="
      ];

      # Don’t die if a cache is missing a build
      fallback = true;
    };
  };
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs;
    [
      nixgl.auto.nixGLDefault
    ]
    ++ lib.optionals x.derived.isLaptop [
      nixgl.nixGLIntel
    ]
    ++ x.ux.fontPkgs
    ++ lib.optionals (x.ux.colorScheme == "wallust") [
      wallustPick
      wallustApplyCurrent
    ];
}
