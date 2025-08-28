{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.features.enableTypst {
    home.packages = with pkgs; [typst];
    programs.zathura = {
      enable = lib.mkDefault true;
    };
  };
}
