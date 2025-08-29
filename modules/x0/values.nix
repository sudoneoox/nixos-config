#INFO: Defaults + host overrides without touching config.*
{
  lib,
  overrides ? {},
}:
lib.fix (
  self: let
    base = rec {
      #INFO: Identity
      identity = {
        username = "diego";
        fullName = "Diego Coronado";
        email = "diegoa2992@proton.me";
        github = "sudoneoox";
        sshKeyPath = "/home/${self.identity.username}/.ssh/id_ed25519.pub";
      };

      #INFO: Paths that depend on identity
      homePath = "/home/${self.identity.username}";
      nixosConfPath = "${self.homePath}/Projects/nixos-config";
      nixosAssetsPath = "${self.homePath}/Assets/nixos-config";
      cachePath = "${self.homePath}/.cache";

      #INFO: System (raw knobs)
      system = {
        hostProfile = "desktop"; # "laptop" | "desktop"
        gpuVendor = "nvidia"; # "intel" | "amd" | "nvidia"
        powerManagement = false;
        cpuVendor = "amd";
        monitors = "multi";
        scale = "1.00";
        security = {
          acipd = true;
          blacklistedModules = true;
          bluetooth = self.features.enableBluetooth;
          boot = true;
          cups = self.features.enablePrinting;
          dbus = true;
          doas = true;
          fail2ban = self.features.enableSSH;
          getty = true;
          kernel = true;
          "network-manager" = true;
          "network-manager-dispatcher" = true;
          #WARN: nix-daemon causes issues with nixos-rebuild
          "nix-daemon" = false;
          "reload-systemd-vconsole-setup" = true;
          rtkit = true;
          ssh = self.features.enableSSH;
          "systemd-ask-password-console" = true;
          systemd = true;
          tor = self.features.enableTor;
          usbguard = true;
          user = true;
          "wpa-supplicant" = true;
        };
      };

      #INFO: Features (can depend on system.hostProfile)
      features = {
        enableCachix = true;
        enableDocker = false;
        enableWine = false;
        enableLibvirt = false;
        enableGaming = false;
        enablePrinting = self.system.hostProfile == "desktop";
        enableBluetooth = true;
        enableFlatpak = false;
        enableResilioSync = true;
        enableUdiskie = true;
        enableAudio = true;
        enableSSH = true;
        enableTor = self.system.hostProfile == "desktop";
        enableQbittorrent = false;
        enableHDR = false;
        enableCider = self.system.hostProfile == "desktop";
        enableZram = true;
        enableRStudio = false;
        enableTypst = true;
        enableZed = false;
      };

      #INFO: Theming / UX
      ux = {
        font = "JetbrainsMono Nerd Font";
        defaultFont = "nerd-fonts.jetbrains-mono";
        fontPkgs = ["nerd-fonts.jetbrains-mono" "nerd-fonts.fira-code" "source-code-pro"];
        fontSize = 11.0;
        cursorTheme = "macOS";
        cursorSize = 24;
        gtkTheme = "Materia-dark";
        iconTheme = "Tela-black";
        qtStyle = "adwaita-dark";
        wallpaper = "nordic.png";
        colorScheme = "wallust";
        de = "hyprland";
      };

      #INFO: Other static paths / keys
      sopsPath = "/var/lib/sops-nix";
      sopsPublicKey = "age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2";

      #INFO: Apps
      apps = {
        terminal = "kitty";
        ide = "zed";
        browser = "zen-twilight";
        fileManager = "thunar";
        editor = "nvim";
      };

      #INFO: Locale
      timezone = "America/Chicago";
      locale = "en_US.UTF-8";
      keyboardLayout = "us";
    };
  in
    lib.recursiveUpdate base overrides
)
