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
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia = {
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
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
      chargeUpto = 80;
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
    openssh.enable = true;
  };

  programs = {
    firefox.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
