{
  inputs,
  config,
  ...
}: {
  imports = [
    "${inputs.nixos-hardware}/common/cpu/amd/zenpower.nix"
    "${inputs.nixos-hardware}/common/cpu/amd/pstate.nix"
    "${inputs.nixos-hardware}/common/cpu/amd"
    "${inputs.nixos-hardware}/common/cpu/amd/raphael/igpu.nix"
    "${inputs.nixos-hardware}/common/gpu/nvidia/ada-lovelace"
    "${inputs.nixos-hardware}/common/pc/ssd"
    "${inputs.nixos-hardware}/common/hidpi.nix"

    ./hardware.nix
    ./disk-config.nix
    ./boot.nix
    ../common
    ../../modules/system/desktop/file-manager
    ../../modules/system/desktop/qbittorrent
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
  };

  home-manager.users.${config.x0.username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
