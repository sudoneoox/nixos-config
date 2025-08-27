{
  pkgs,
  lib,
  X0,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_TYPST {
    home.packages = with pkgs; [typst];
    programs.zathura = {
      enable = lib.mkDefault true;
    };
  };
}
