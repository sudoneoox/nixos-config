{
  inputs,
  config,
  ...
}: let
  x = config.x0;
in {
  imports = [
    #INFO: NixOS-hardware input
    "${inputs.nixos-hardware}/common/cpu/intel/meteor-lake"
    "${inputs.nixos-hardware}/common/gpu/nvidia/ada-lovelace"
    "${inputs.nixos-hardware}/common/gpu/nvidia/prime.nix"
    "${inputs.nixos-hardware}/common/pc/laptop/hdd"
    "${inputs.nixos-hardware}/common/pc/laptop"
    "${inputs.nixos-hardware}/common/hidpi.nix"

    ./hardware.nix
    ./boot.nix
    ./disk-config.nix
    ../common
    ../../modules/system/desktop/file-manager
    ../../modules/system/desktop/qbittorrent
  ];

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
  };

  home-manager.users.${x.username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
