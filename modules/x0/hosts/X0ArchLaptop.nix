{
  lib,
  pkgs,
}:
import ../values.nix {
  inherit lib pkgs;
  overrides = {
    system = {
      hostProfile = "laptop";
      gpuVendor = "nvidia";
      cpuVendor = "intel";
      monitors = "single";
    };
    identity = {
      OS = "arch";
    };
    features = {
      enableNixcord = false;
      enableCachix = false;
      enableDocker = false;
      enableWinboat = false;
      enableWine = false;
      enableLibvirt = false;
      enableGaming = false;
      enablePrinting = false;
      enableBluetooth = false;
      enableFlatpak = false;
      enableResilioSync = false;
      enableUdiskie = false;
      enableAudio = false;
      enableSSH = false;
      enableTor = false;
      enableQbittorrent = false;
      enableHDR = false;
      enableCider = false;
      enableZram = false;
      enableRStudio = false;
      enableTypst = false;
      enableZed = false;
      enableLuks = false;
      enableKDEConnect = false;
    };
  };
}
