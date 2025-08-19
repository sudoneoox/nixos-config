{
  inputs,
  pkgs,
  custom_vars,
  ...
}: {
  imports = [
    #INFO: NixOS-hardware input
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

  home-manager.users.${custom_vars.USERNAME} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
