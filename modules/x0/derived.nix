{config, ...}: {
  config.x0.derived = {
    isLaptop = config.x0.system.hostProfile == "laptop";
    isDesktop = config.x0.system.hostProfile == "desktop";
    isIntel = config.x0.system.cpuVendor == "intel";
    isNvidia = config.x0.system.gpuVendor == "nvidia";
    isMultiMonitor = config.x0.system.monitors == "multi";
  };
}
