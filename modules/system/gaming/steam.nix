{
  pkgs,
  lib,
  config,
  ...
}: {
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
