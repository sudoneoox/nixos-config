{config, ...}: let
  x = config.x0;
  isLaptop = x.system.hostProfile == "laptop";
  isDesktop = x.system.hostProfile == "desktop";

  cpuVendorEff =
    if isLaptop
    then "intel"
    else x.system.cpuVendor;
  monitorsEff =
    if isLaptop
    then "single"
    else x.system.monitors;
  powerMgmtEff =
    if isLaptop
    then true
    else x.system.powerManagement;
  primaryMonitor =
    if isLaptop
    then "eDP-1"
    else null;
in {
  config.x0.derived = {
    homeDir = "/home/${x.username}";
    isLaptop = isLaptop;
    isDesktop = isDesktop;
    cpuVendorEff = cpuVendorEff;
    monitorsEff = monitorsEff;
    powerMgmtEff = powerMgmtEff;
    primaryMonitor = primaryMonitor;
  };
}
