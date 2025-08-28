{
  pkgs,
  lib,
  X0,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_GAMING {
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
