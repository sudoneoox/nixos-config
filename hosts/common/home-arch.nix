
{ lib, pkgs, custom ? { x0 = { identity = { username = builtins.getEnv "USER"; email = ""; }; }; }, ... }:
{
  home = {
    username      = custom.x0.identity.username;
    homeDirectory = "/home/${custom.x0.identity.username}";
    stateVersion  = "25.05";
  };

  # XDG on, so ~/.config is managed via xdg.configFile
  xdg.enable = true;

  # Import whichever home module groups you already have
  imports = [
    ./../../modules/home/devel/default.nix
    ./../../modules/home/desktop/default.nix
    ./../../modules/home/utils/default.nix
    ./../../modules/home/zen/default.nix
  ];

  # If some submodules rely on features flags from custom.x0, either:
  #  a) keep using custom.x0.features.* from your values.nix, or
  #  b) set feature flags here (mkDefault/mkForce) for Arch
  # example:
  # config = { someOption = lib.mkDefault true; };

  # Packages that many of your configs assume:
  home.packages = with pkgs; [
    ripgrep fd jq unzip
  ];
}
