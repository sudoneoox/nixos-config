{
  inputs,
  pkgs,
  custom_vars,
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
    ../common
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
  };

  home-manager.users.${custom_vars.USERNAME} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
