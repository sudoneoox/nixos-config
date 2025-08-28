{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.features.enableZram {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 5;
      memoryPercent = 50;
    };
  };
}
