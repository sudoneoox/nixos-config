{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.x0 = {
    # NOTE: `homePath` is kept but discouraged use derivation

    homePath = mkOption {
      type = types.str;
      description = "recursive attribute; do not use; use x0.derived.homeDir";
      default = "/home/unknown";
    };

    debug = mkOption {
      type = types.bool;
      description = "for allowing debug statements to run";
      default = false;
    };

    ####INFO: Identity
    identity = {
      username = mkOption {
        type = types.str;
        description = "Primary username";
        default = "unknown";
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

    repos = {
      schoolNotes = mkOption {
        type = types.str;
        default = "";
        description = "Github repo to your school notes, see modules/system/utils/systemd/school-notes-sync";
      };
    };

    ####INFO: Derived (filled by config below)
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
      powerMgmtPerf = mkOption {
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

    ####INFO: System / Profile
    system = {
      hostProfile = mkOption {
        type = types.enum ["laptop" "desktop"];
        default = "desktop";
      };
      gpuVendor = mkOption {
        type = types.enum ["intel" "amd" "nvidia"];
        default = "nvidia";
      };
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

      #NOTE: hyphen keys must be quoted
      security = {
        acipd = mkOption {
          type = types.bool;
          default = true;
        };
        blacklistedModules = mkOption {
          type = types.bool;
          default = true;
        };
        bluetooth = mkOption {
          type = types.bool;
          default = true;
        };
        boot = mkOption {
          type = types.bool;
          default = true;
        };
        cups = mkOption {
          type = types.bool;
          default = true;
        };
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
        };
        getty = mkOption {
          type = types.bool;
          default = true;
        };
        kernel = mkOption {
          type = types.bool;
          default = true;
        };
        "network-manager" = mkOption {
          type = types.bool;
          default = true;
        };
        "network-manager-dispatcher" = mkOption {
          type = types.bool;
          default = true;
        };
        "nix-daemon" = mkOption {
          type = types.bool;
          default = false;
        };
        proton = mkOption {
          type = types.bool;
          default = false;
        };
        "reload-systemd-vconsole-setup" = mkOption {
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
        };
        "systemd-ask-password-console" = mkOption {
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
        };
        usbguard = mkOption {
          type = types.bool;
          default = true;
        };
        user = mkOption {
          type = types.bool;
          default = true;
        };
        "wpa-supplicant" = mkOption {
          type = types.bool;
          default = true;
        };
        veracrypt = mkOption {
          type = types.bool;
          default = true;
        };
      };
    };

    ####INFO: Features
    features = {
      enableNixcord = mkOption {
        type = types.bool;
        default = true;
      };
      enableKDEConnect = mkOption {
        type = types.bool;
        default = false;
      };

      enableLuks = mkOption {
        type = types.bool;
        default = false;
      };

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
      };
      enableBluetooth = mkOption {
        type = types.bool;
        default = true;
      };
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

    ####INFO: Theming / UX
    ux = {
      font = mkOption {
        type = types.str;
        default = "JetbrainsMono Nerd Font";
      };
      defaultFont = mkOption {
        type = types.str;
        default = "nerd-fonts.jetbrains-mono";
      };
      fontPkgs = lib.mkOption {
        type =
          lib.types.coercedTo
          (lib.types.listOf lib.types.str)
          (
            paths: let
              toPkg = path: lib.getAttrFromPath (lib.splitString "." path) pkgs;
            in
              builtins.map toPkg paths
          )
          (lib.types.listOf lib.types.package);

        # You can set default as real packages (nice and fast),
        # but values.nix can still provide strings or packages — both work.
        default = [
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.nerd-fonts.fira-code
          pkgs.source-code-pro
        ];

        description = "Font packages for installation.";
      };

      fontSize = mkOption {
        type = types.number;
        default = 11.0;
      };
      cursorTheme = mkOption {
        type = types.str;
        default = "macOS";
      };
      cursorPkg = lib.mkOption {
        type =
          lib.types.coercedTo
          lib.types.str
          (s: lib.getAttrFromPath (lib.splitString "." s) pkgs)
          lib.types.package;

        default = pkgs.apple-cursor;
        description = "Cursor package (accepts a package or a pkgs-attrpath string).";
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

    ####INFO: Paths / keys
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
    currentSchoolSemester = mkOption {
      type = types.str;
      default = "";
    };
    sopsPath = mkOption {
      type = types.str;
      default = "/var/lib/sops-nix";
    };
    sopsPublicKey = mkOption {
      type = types.str;
      default = "";
    };

    ####INFO: Default Apps
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
        default = "zen-twilight";
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

    ####INFO: Locale / Input
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

  #NOTE: ------- DERIVED -------
  config = let
    c = config.x0;
    isLaptop = c.system.hostProfile == "laptop";
    isDesktop = c.system.hostProfile == "desktop";
    cpuVendorEff =
      if isLaptop
      then "intel"
      else c.system.cpuVendor;
    monitorsEff =
      if isLaptop
      then "single"
      else c.system.monitors;
    powerMgmtEff =
      if isLaptop
      then true
      else c.system.powerManagement;
    powerMgmtPerf =
      if isDesktop
      then true
      else c.system.powerManagement;
    primaryMonitor =
      if isLaptop
      then "eDP-1"
      else null;
  in {
    x0.derived = {
      homeDir = "/home/${c.identity.username}";
      inherit isLaptop isDesktop cpuVendorEff monitorsEff powerMgmtEff powerMgmtPerf primaryMonitor;
    };
  };
}
