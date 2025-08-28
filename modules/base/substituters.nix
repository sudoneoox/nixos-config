#WARN: to use your own cachix repo refer to this
# https://saylesss88.github.io/nix/cachix_devour.html
# Generally make a repo and generate an authkey then
# cachix authtoken <YOUR_TOKEN>
# cachix use <your-cache-name>
{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableCachix {
    environment.systemPackages = with pkgs; [cachix];
    nix.settings = {
      substituters =
        [
          "https://cache.nixos.org?priority=10"
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://hyprland.cachix.org"
          "https://nyx.chaotic.cx"
          "https://nvf.cachix.org"
          "https://neovim-nightly.cachix.org"
          #NOTE: My own cachix
          "https://nixossudnox.cachix.org"
        ]
        ++ lib.optionals x.features.enableRstudio [
          "https://rstats-on-nix.cachix.org"
        ];
      trusted-public-keys =
        [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
          "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
          #NOTE: My own cachix
          "nixossudnox.cachix.org-1:ZwKSBOS8npDqpdX9cg7kMvEx5dOSYq05O69qm5O0mLg="
        ]
        ++ lib.optionals x.features.enableRstudio [
          "rstats-on-nix.cachix.org-1:vdiiVgocg6WeJrODIqdprZRUrhi1JzhBnXv7aWI6+F0="
        ];
    };
  };
}
