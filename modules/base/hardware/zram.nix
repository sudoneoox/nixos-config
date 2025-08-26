{
  lib,
  config,
  custom_vars,
}: {
  config = lib.mkIf custom_vars.FEATURES.ENABLE_ZRAM {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 5;
      memoryPercent = 50;
    };
  };
}
