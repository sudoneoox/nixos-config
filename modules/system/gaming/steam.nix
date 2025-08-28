{
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf config.x0.features.enableGaming {
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohub
    ];
  };
}
