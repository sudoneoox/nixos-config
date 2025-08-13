{
  inputs,
  pkgs,
  lib,
  username,
  host,
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

    ../../modules/nixos/desktop/hyprland
    ../../modules/nixos/virtualisation/qemu.nix
    ../../modules/nixos/virtualisation/wine.nix
    ../../modules/nixos/discord
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

  networking.hostName = host;

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
    openssh.enable = true;
    thermald.enable = true;
  };

  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
