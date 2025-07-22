{ inputs, outputs, config, pkgs, lib, self, username, email, ... }:
{
  imports = [
    ../temp/hardware.nix
    ../common
    ../../modules/nixos/desktop/awesome
    # ../../modules/nixos/desktop/hyprland
  ];

  networking = {
    hostName = "X0-nixos-laptop"; # Define your hostname.
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/vda";
        useOSProber = true;
      };
    };

    supportedFilesystems = [ "ntfs" ];
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    graphics.enable32Bit = true;
  };



  services = {

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
    spice-vdagentd.enable = true;
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

