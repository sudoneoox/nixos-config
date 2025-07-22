{ outputs, username, inputs, ... }:

{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    ../../modules/home/devel
  ];



  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };


  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;

  system.user.startServices = "sd-switch";

}
