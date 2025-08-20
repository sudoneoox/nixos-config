{
  pkgs,
  lib,
  custom_vars,
  ...
}: {
  config = lib.mkIf custom_vars.ENABLE_CACHIX {
    environment.systemPackages = with pkgs; [cachix];
    nix.settings = {
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://nyx.chaotic.cx"
        "https://nvf.cachix.org"
        "https://neovim-nightly.cachix.org"
        # My own cachix
        "https://nixossudnox.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
        "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
        # My own cachix
        "nixossudnox.cachix.org-1:ZwKSBOS8npDqpdX9cg7kMvEx5dOSYq05O69qm5O0mLg="
      ];
    };
  };
}
