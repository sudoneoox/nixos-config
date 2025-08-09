{
  inputs,
  pkgs,
  lib,
  username,
  ...
}:
{
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

    ../../modules/nixos/desktop/hyprland
    ../../modules/nixos/virtualisation/qemu.nix
    ../../modules/nixos/virtualisation/wine.nix
    ../../modules/nixos/discord
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
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
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    asus.battery = {
      chargeUpto = 75;
      enableChargeUptoScript = true;
    };
  };

  networking.hostName = "X0NixOSLaptop";

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
    openssh.enable = true;
    tlp = {
      enable = true;
      settings.CPU_SCALING_GOVERNER_ON_AC = "performance";
      settings.CPU_SCALING_GOVERNER_ON_BAT = "powersave";
      settings.CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      settings.CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      settings.CPU_MIN_PERF_ON_AC = 0;
      settings.CPU_MAX_PERF_ON_AC  = 100;
      settings.CPU_MIN_PERF_ON_BAT = 0;
      settings.CPU_MAX_PERF_ON_BAT = 20;
      settings.START_CHARGE_THRESH_BAT0 = 40;
    };
    thermald.enable = true;
    asusd.enable = true;
    asusd.enableUserService = true;
  };

  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
