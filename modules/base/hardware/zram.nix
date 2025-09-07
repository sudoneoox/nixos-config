{
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableZram {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 100;
      memoryPercent = 50;
    };
  };
}
