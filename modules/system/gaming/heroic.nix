{
  pkgs,
  lib,
  X0,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_GAMING {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
