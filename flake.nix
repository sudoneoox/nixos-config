{
  description = "Diego's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-25.05";
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vimPlugins-neopywal = {
      url = "github:RedsXDD/neopywal.nvim";
      flake = false;
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs.lib) nixosSystem;
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    forallSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];

    customLib = import ./lib/custom-x0.nix {inherit lib pkgs system;};

    # Load raw values (plain)
    x0Values = import ./modules/x0/values.nix;

    # Type-check + derive in a sandbox; get a PLAIN attrset back
    x0Checked = customLib.mkX0 x0Values;

    mkNixOSConfig = host: {
      system = "x86_64-linux";
      specialArgs = {
        custom = {x0 = x0Checked;};
        inherit inputs host self;
        outputs = self.outputs;
      };
      modules = [
        ./hosts/${host}
      ];
    };
  in {
    overlays = import ./overlays {inherit inputs;};
    formatter = forallSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      X0NixOSLaptop = nixosSystem (mkNixOSConfig "X0NixOSLaptop");
      X0NixOSDesktop = nixosSystem (mkNixOSConfig "X0NixOSDesktop");
    };
  };
}
