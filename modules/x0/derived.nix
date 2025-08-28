{config, ...}: let
  isLaptop = config.x0.system.hostProfile == "laptop";
  isDesktop = config.x0.system.hostProfile == "desktop";
  cpuVendorEff =
    if isLaptop
    then "intel"
    else config.x0.system.cpuVendor;
  monitorsEff =
    if isLaptop
    then "single"
    else config.x0.system.monitors;
  powerMgmtEff =
    if isLaptop
    then true
    else config.x0.system.powerManagement;
  primaryMonitor =
    if isLaptop
    then "eDP-1"
    else null;
in {
  config.x0.derived = {
    homeDir = "/home/${config.x0.identity.username}";
    isLaptop = isLaptop;
    isDesktop = isDesktop;
    cpuVendorEff = cpuVendorEff;
    monitorsEff = monitorsEff;
    powerMgmtEff = powerMgmtEff;
    primaryMonitor = primaryMonitor;
  };
}
