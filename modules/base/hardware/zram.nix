{
  lib,
  X0,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_ZRAM {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 5;
      memoryPercent = 50;
    };
  };
}
