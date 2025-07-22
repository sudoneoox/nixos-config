{ config, lib, pkgs, ... }:

{

  boot.kernelParams = [
    "i915.force_probe=7d55"
  ];

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiIntel
      intel-media-driver
      vpl-gpu-rt
    ];
    extraPackages32 = with pkgs; [
      vaapiIntel
      intel-media-driver
      vpl-gpu-rt
    ];
  };


  hardware.nvidia = {
    modesetting.enable = true; # Required = true
    powerManagement.enable = false; # Nvidia Power Management. Experimental
    powerManagement.finegrained = false; #  Turns off GPU when not in use
    open = false; # Use Open Source Drivers
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:1:0";
      sync.enable = true;
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
    };


  };

}
