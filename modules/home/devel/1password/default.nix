{
  custom,
  lib,
  pkgs,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.system.security."1password" {
    home.packages = with pkgs; [
      _1password
      _1password-gui
    ];
  };
}
