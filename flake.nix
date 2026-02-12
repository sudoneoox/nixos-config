{
  description = "Diego's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-25.05";
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };

    # Allows the ability to manage system files in non-nixos systems
    system-manager.url = "github:numtide/system-manager";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl.url = "github:nix-community/nixGL";
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

    nixcord = {
      url = "github:kaylorben/nixcord";
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
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    customLib = import ./lib/custom-x0.nix {inherit lib pkgs system;};

    #NOTE: Produce default/base (desktop) values defined in modules/x0/values.nix
    makeValues = overrides:
      import ./modules/x0/values.nix {inherit lib pkgs overrides;};

    #NOTE: per-host values
    x0ValuesDesktop = makeValues {}; # keep default "desktop"
    x0ValuesLaptop = makeValues {system.hostProfile = "laptop";};
    x0ValuesArchDesktop = makeValues {identity.OS = "arch";};
    x0ValuesArchLaptop = makeValues {
      system.hostProfile = "laptop";
      identity.OS = "arch";
    };

    #NOTE: type-check + derive in sandbox → plain attrsets
    x0Desktop = customLib.mkX0 x0ValuesDesktop;
    x0Laptop = customLib.mkX0 x0ValuesLaptop;
    x0ArchLaptop = customLib.mkX0 x0ValuesArchLaptop;
    x0ArchDesktop = customLib.mkX0 x0ValuesArchDesktop;

    forallSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];

    mkNixOSConfig = host: {
      system = "x86_64-linux";
      specialArgs = {
        custom = {
          x0 =
            if host == "X0NixOSLaptop"
            then x0Laptop
            else x0Desktop;
        };
        inherit inputs host self;
        outputs = self.outputs;
      };
      modules = [
        ./hosts/${host}
      ];
    };
  in {
    #TODO: find a way to pass host for host specific overlays
    overlays = import ./overlays {
      inherit inputs;
      custom = {
        x0 = x0Desktop;
      };
    };
    formatter = forallSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      X0NixOSLaptop = nixosSystem (mkNixOSConfig "X0NixOSLaptop");
      X0NixOSDesktop = nixosSystem (mkNixOSConfig "X0NixOSDesktop");
    };

    #INFO: -------- Home Manager standalone for Arch (home-only) --------
    # Uses common/x0 (i.e., modules/x0/values.nix via mkX0) for feature flags.
    homeConfigurations = {
      # Key name for rebuilding is user@arch{-laptop}
      "${x0Desktop.identity.username}@ArchDesktop" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          custom = {x0 = x0ArchDesktop;};
          inherit inputs self;
          outputs = self.outputs;
        };
        modules = [./hosts/Arch-HM];
      };

      "${x0Desktop.identity.username}@ArchLaptop" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          custom = {x0 = x0ArchLaptop;};
          inherit inputs self;
          outputs = self.outputs;
        };
        modules = [./hosts/Arch-HM];
      };
    };

    #INFO: for sanity checks
    # nix eval .#custom.x0Laptop.derived --json | jq
    # nix eval .#custom.x0Laptop.features --json | jq
    custom = {
      x0Desktop = x0Desktop;
      x0Laptop = x0Laptop;
    };
  };
}
