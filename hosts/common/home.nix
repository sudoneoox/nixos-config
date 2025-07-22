{ outputs, username, inputs, ... }:

{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    ../../modules/home/devel
  ];


  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;

}
