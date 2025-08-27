{
  lib,
  pkgs,
  ...
}: {
  boot = {
    initrd.luks.devices.cryptroot = {
      device = "/dev/disk/by-partlabel/luks";
      allowDiscards = true;
      preLVM = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = lib.mkDefault "max";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
    consoleLogLevel = 3;
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["rings"];
        })
      ];
    };
  };
}
