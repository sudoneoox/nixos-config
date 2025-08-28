{lib, ...}:
with lib; {
  options.x0 = {
    username = mkOption {
      type = types.str;
      description = "Primary user";
    };
    colorScheme = mkOption {
      type = types.enum ["wallust"];
      default = "wallust";
    };
    cursorSize = mkOption {
      type = types.ints.positive;
      default = 26;
    };
    system = {
      hostProfile = mkOption {
        type = types.enum ["laptop" "desktop"];
        default = "desktop";
      };
      cpuVendor = mkOption {
        type = types.enum ["intel" "amd"];
      };
      gpuVendor = mkOption {
        type = types.enum ["nvidia"];
        default = "nvidia";
      };
      monitors = mkOption {
        type = types.enum ["single" "multi"];
      };
      scale = mkOption {
        type = types.str;
        default = "1.00";
      };
      security = {
        acipd = mkOption {
          type = types.bool;
          default = true;
        };
        usbguard = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
    features = {
      gaming = mkEnableOption "gaming stack";
      docker = mkEnableOption "docker";
      libvirt = mkEnableOption "libvirt";
      wine = mkEnableOption "wine";
      udiskie = mkEnableOption "udiskie";
      audio = mkEnableOption "audio";
      bluetooth = mkEnableOption "bluetooth";
    };
    paths = {
      cache = mkOption {
        type = types.path;
        description = "Cache path";
      };
      assets = mkOption {
        type = types.path;
        description = "Assets path";
      };
    };
    font = {
      family = mkOption {
        type = types.str;
        default = "JetBrainsMono Nerd Font";
      };
      size = mkOption {
        type = types.ints.positive;
        default = 10;
      };
    };
  };
}
