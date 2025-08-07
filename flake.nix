{
  description = "Diego's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-25.05";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };

    sawm = {
      url = "github:sudoneoox/sawm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sfish = {
      url = "github:sudoneoox/sfish";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snvim = {
      url = "github:sudoneoox/snvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    skitty = {
      url = "github:sudoneoox/skitty";
      inputs.nixpkgs.follows = "nixpkgs";
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

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

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

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;

      username = "diego";
      email = "diegoa2992@proton.me";
      forallSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];

      mkNixOSConfig = host: {
        system = "x86_64-linux";
        specialArgs = {
          inherit
            inputs
            outputs
            username
            email
            host
            ;
        };
        modules = [ ./hosts/${host} ];
      };

    in
    {
      overlays = import ./overlays { inherit inputs; };
      formatter = forallSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      nixosConfigurations = {
        X0NixOSLaptop = nixosSystem (mkNixOSConfig "X0NixOSLaptop");
        X0NixOSDesktop = nixosSystem (mkNixOSConfig "X0NixOSDesktop");
      };
    };

}
