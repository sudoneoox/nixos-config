{
  inputs,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    "${inputs.nixos-hardware}/common/cpu/intel/meteor-lake"
    "${inputs.nixos-hardware}/common/gpu/nvidia/ada-lovelace"
    "${inputs.nixos-hardware}/common/gpu/nvidia/prime.nix"
    "${inputs.nixos-hardware}/common/pc/laptop/hdd"
    "${inputs.nixos-hardware}/common/pc/laptop"
    "${inputs.nixos-hardware}/common/hidpi.nix"
    "${inputs.nixos-hardware}/asus/battery.nix"

    ./hardware.nix
    ../common

    ../../modules/system/desktop/file-manager
    ../../modules/system/desktop/qbittorrent
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia = {
      prime.intelBusId = "PCI:0:2:0";
      prime.nvidiaBusId = "PCI:1:0:0";
      primeBatterySaverSpecialisation = true;
    };
    intelgpu = {
      driver = "xe";
      loadInInitrd = true;
      vaapiDriver = "intel-media-driver";
      enableHybridCodec = true;
    };

    asus.battery = {
      chargeUpto = 75;
      enableChargeUptoScript = true;
    };
  };

  security.rtkit.enable = true;

  services = {
    fstrim.enable = lib.mkDefault true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNER_ON_AC = "performance";
        CPU_SCALING_GOVERNER_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balance_power";
        CPU_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
    };
    thermald.enable = true;
  };

  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
