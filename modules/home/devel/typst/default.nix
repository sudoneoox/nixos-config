{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableTypst {
    home.packages = with pkgs; [typst];
    programs.zathura = {
      enable = lib.mkDefault true;
    };
  };
}
