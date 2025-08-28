{
  pkgs,
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableUdiskie {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };
    home.packages = [pkgs.udiskie];
  };
}
