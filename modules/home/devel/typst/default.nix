{
  pkgs,
  lib,
  custom_vars,
  ...
}: {
  config = lib.mkIf custom_vars.FEATURES.ENABLE_TYPST {
    home.packages = with pkgs; [typst];
    programs.zathura = {
      enable = lib.mkDefault true;
    };
  };
}
