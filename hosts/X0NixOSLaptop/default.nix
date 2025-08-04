{
  inputs,
  pkgs,
  lib,
  username,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops

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
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };

  sops.defaultSopsFile = ../common/common.secrets.enc.yaml;
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  sops.secrets = {
    "wifi-psk" = {
      owner = "root";
      mode = "0400";
    };
  };

  networking = {
    hostName = "X0NixOSLaptop";
    networkmanager.enable = true;
    networkmanager.ensureProfiles = {
      secrets.entries = [
        {
          matchId = "ATTRpV6p4h"; # SSID
          matchSetting = "802-11-wireless-security";
          key = "psk";
          file = config.sops.secrets."wifi-psk".path;
        }
      ];

      profiles."HomeWiFi" = {
        connection = {
          id = "HomeWiFi";
          type = "802-11-wireless";
          interface-name = "wlo1";
          uuid = "bea8b595-75a5-43ed-991a-4728cdfb8762";
        };

        "802-11-wireless" = {
          ssid = "ATTRpV6p4h";
          mode = "infrastructure";
          security = "802-11-wireless-security";
        };

        "802-11-wireless-security" = {
          key-mgmt = "wpa-psk";
          # no 'psk' field here; it's injected via secrets
        };

        ipv4 = {
          method = "auto";
        };

        ipv6 = {
          method = "auto";
        };
      };
    };
    firewall.enable = true;
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
    nm-applet.enable = true;
  };

  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
