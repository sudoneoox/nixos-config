{ lib, pkgs, ... }: {

  services = {
    displayManager = {
      defaultSession = "none+awesome";
    };

    xserver = {
      libinput.enable = true;
      enable = true;
      autorun = false;
      displayManager.sddm.enable = true;
      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome;
        luaModules = lib.attrValues {
          inherit
            (pkgs.luajitPackages)
            lgi
            ldbus
            luadbi-mysql
            luaposix
            dkjson
            ;
        };
      };
    };

    acpid.enable = true;
    upower.enable = true;
    blueman.enable = true;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    luajit
    luajitPackages.lgi
    acpi
    lxappearance
    xdotool
    xclip
    xorg.xbacklight
    alsa-utils
    pavucontrol
    brightnessctl
    libnotify
    xdg-utils
    pulsemixer
    xorg.xauth
    xorg.xinit
  ];

}
