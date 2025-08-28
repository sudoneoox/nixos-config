{lib, ...}:
with lib; {
  options.x0 = {
    username = mkOption {
      type = types.str;
      description = "recursive attribute do not use; use x0.identity.username";
    };

    homePath = mkOption {
      type = types.str;
      description = "recursive attribute do not use; use x0.derived.homeDir";
    };

    ###INFO: --- Identity ----
    identity = {
      username = mkOption {
        type = types.str;
        description = "Primary username";
      };
      fullName = mkOption {
        type = types.str;
        default = "";
      };
      email = mkOption {
        type = types.str;
        default = "";
      };
      github = mkOption {
        type = types.str;
        default = "";
      };
      sshKeyPath = mkOption {
        type = types.str;
        default = "";
        description = "Path to SSH key (pub or private).";
      };
    };

    ###INFO: --- Derived basics (filled in derived.nix) ----
    derived = {
      homeDir = mkOption {
        type = types.str;
        internal = true;
        default = "/home/unknown";
      };
      isLaptop = mkOption {
        type = types.bool;
        internal = true;
        default = false;
      };
      isDesktop = mkOption {
        type = types.bool;
        internal = true;
        default = true;
      };
      cpuVendorEff = mkOption {
        type = types.enum ["intel" "amd"];
        internal = true;
        default = "amd";
      };
      monitorsEff = mkOption {
        type = types.enum ["single" "multi"];
        internal = true;
        default = "single";
      };
      powerMgmtEff = mkOption {
        type = types.bool;
        internal = true;
        default = false;
      };
      primaryMonitor = mkOption {
        type = types.nullOr types.str;
        internal = true;
        default = null;
      };
    };

    ###INFO: --- System / Profile ----
    system = {
      hostProfile = mkOption {
        type = types.enum ["laptop" "desktop"];
        default = "desktop";
      };
      gpuVendor = mkOption {
        type = types.enum ["intel" "amd" "nvidia"];
        default = "nvidia";
      };

      # The following three in your original are derived from hostProfile.
      # We still expose user-settable values; derived.nix will compute *Eff* versions.
      powerManagement = mkOption {
        type = types.bool;
        default = false;
      };
      cpuVendor = mkOption {
        type = types.enum ["intel" "amd"];
        default = "amd";
      };
      monitors = mkOption {
        type = types.enum ["single" "multi"];
        default = "multi";
      };

      scale = mkOption {
        type = types.str;
        default = "1.00";
      };

      security = {
        # keep every switch you had; default mirrors your original
        acipd = mkOption {
          type = types.bool;
          default = true;
        }; # (kept your field name)
        blacklistedModules = mkOption {
          type = types.bool;
          default = true;
        };
        bluetooth = mkOption {
          type = types.bool;
          default = true;
        }; # was FEATURES.ENABLE_BLUETOOTH; resolved in derived too
        boot = mkOption {
          type = types.bool;
          default = true;
        };
        cups = mkOption {
          type = types.bool;
          default = true;
        }; # was FEATURES.ENABLE_PRINTING
        dbus = mkOption {
          type = types.bool;
          default = true;
        };
        doas = mkOption {
          type = types.bool;
          default = true;
        };
        fail2ban = mkOption {
          type = types.bool;
          default = true;
        }; # was FEATURES.ENABLE_SSH
        getty = mkOption {
          type = types.bool;
          default = true;
        };
        kernel = mkOption {
          type = types.bool;
          default = true;
        };
        network-manager = mkOption {
          type = types.bool;
          default = true;
        };
        network-manager-dispatcher = mkOption {
          type = types.bool;
          default = true;
        };
        nix-daemon = mkOption {
          type = types.bool;
          default = false;
        };
        reload-systemd-vconsole-setup = mkOption {
          type = types.bool;
          default = true;
        };
        rtkit = mkOption {
          type = types.bool;
          default = true;
        };
        ssh = mkOption {
          type = types.bool;
          default = true;
        }; # was FEATURES.ENABLE_SSH
        systemd-ask-password-console = mkOption {
          type = types.bool;
          default = true;
        };
        systemd = mkOption {
          type = types.bool;
          default = true;
        };
        tor = mkOption {
          type = types.bool;
          default = false;
        }; # was FEATURES.ENABLE_TOR
        usbguard = mkOption {
          type = types.bool;
          default = true;
        };
        user = mkOption {
          type = types.bool;
          default = true;
        };
        wpa-supplicant = mkOption {
          type = types.bool;
          default = true;
        };
      };
    };

    ###INFO: --- Feature flags ----
    features = {
      enableCachix = mkOption {
        type = types.bool;
        default = true;
      };
      enableDocker = mkOption {
        type = types.bool;
        default = false;
      };
      enableWine = mkOption {
        type = types.bool;
        default = false;
      };
      enableLibvirt = mkOption {
        type = types.bool;
        default = false;
      };
      enableGaming = mkOption {
        type = types.bool;
        default = false;
      };
      enablePrinting = mkOption {
        type = types.bool;
        default = true;
      }; # desktop default
      enableBluetooth = mkOption {
        type = types.bool;
        default = true;
      }; # desktop default
      enableFlatpak = mkOption {
        type = types.bool;
        default = false;
      };
      enableResilioSync = mkOption {
        type = types.bool;
        default = true;
      };
      enableUdiskie = mkOption {
        type = types.bool;
        default = true;
      };
      enableAudio = mkOption {
        type = types.bool;
        default = true;
      };
      enableSSH = mkOption {
        type = types.bool;
        default = true;
      };
      enableTor = mkOption {
        type = types.bool;
        default = false;
      };
      enableQbittorrent = mkOption {
        type = types.bool;
        default = false;
      };
      enableHDR = mkOption {
        type = types.bool;
        default = false;
      };
      enableCider = mkOption {
        type = types.bool;
        default = false;
      };
      enableZram = mkOption {
        type = types.bool;
        default = true;
      };
      enableRStudio = mkOption {
        type = types.bool;
        default = false;
      };
      enableTypst = mkOption {
        type = types.bool;
        default = true;
      };
      enableZed = mkOption {
        type = types.bool;
        default = false;
      };
    };

    ###INFO: --- Theming / UX ----
    ux = {
      font = mkOption {
        type = types.str;
        default = "JetbrainsMono Nerd Font";
      };
      defaultFont = mkOption {
        type = types.str;
        default = "nerd-fonts.jetbrains-mono";
      };
      fontPkgs = mkOption {
        type = types.listOf types.str;
        default = ["nerd-fonts.jetbrains-mono" "nerd-fonts.fira-code" "source-code-pro"];
      };

      fontSize = mkOption {
        type = types.number;
        default = 11.0;
      };
      cursorTheme = mkOption {
        type = types.str;
        default = "macOS";
      };
      cursorSize = mkOption {
        type = types.int;
        default = 24;
      };
      gtkTheme = mkOption {
        type = types.str;
        default = "Materia-dark";
      };
      iconTheme = mkOption {
        type = types.str;
        default = "Tela-black";
      };
      qtStyle = mkOption {
        type = types.str;
        default = "adwaita-dark";
      };
      wallpaper = mkOption {
        type = types.str;
        default = "nordic.png";
      };
      colorScheme = mkOption {
        type = types.enum ["wallust"];
        default = "wallust";
      };
      de = mkOption {
        type = types.enum ["hyprland"];
        default = "hyprland";
      };
    };

    ###INFO: --- Paths / keys ----
    nixosConfPath = mkOption {
      type = types.str;
      default = "/home/unknown/Projects/nixos-config";
    };
    nixosAssetsPath = mkOption {
      type = types.str;
      default = "/home/unknown/Assets/nixos-config";
    };
    cachePath = mkOption {
      type = types.str;
      default = "/home/unknown/.cache";
    };
    sopsPath = mkOption {
      type = types.str;
      default = "/var/lib/sops-nix";
    };
    sopsPublicKey = mkOption {
      type = types.str;
      default = "";
    };

    ###INFO: --- Default Apps ----
    apps = {
      terminal = mkOption {
        type = types.str;
        default = "kitty";
      };
      ide = mkOption {
        type = types.str;
        default = "zed";
      };
      browser = mkOption {
        type = types.str;
        default = "zen-browser-twilight";
      };
      fileManager = mkOption {
        type = types.str;
        default = "thunar";
      };
      editor = mkOption {
        type = types.str;
        default = "nvim";
      };
    };

    ###INFO: --- Locale / Input ----
    timezone = mkOption {
      type = types.str;
      default = "America/Chicago";
    };
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
    };
    keyboardLayout = mkOption {
      type = types.str;
      default = "us";
    };
  };
}
