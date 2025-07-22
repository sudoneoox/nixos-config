{ inputs, pkgs, lib, username, email, ... }:
{
  imports = [
    ./hardware.nix
    #./graphics.nix
    ../common
    # ../../modules/nixos/desktop/awesome
    ../../modules/nixos/desktop/plasma
  ];


  boot = {
    loader = {
      grub.enable = true;
      grub.device = "/dev/vda";
      grub.useOSProber = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };


  networking = {
    hostName = "X0NixOSLaptop";
    networkmanager.enable = true;
    firewall.enable = true;
  };


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  services = {
    xserver.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    libinput.enable = true;
    openssh.enable = true;
  };




  programs = {
    firefox.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
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

