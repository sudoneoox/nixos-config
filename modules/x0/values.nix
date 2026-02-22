#INFO: Defaults + host overrides without touching config.*
{
  lib,
  pkgs,
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
        #WARN: This should be managed by 1pass need to remove later
        sshKeyPath = "/home/${self.identity.username}/.ssh/id_ed25519.pub";
        OS = "nix";
      };

      repos = {
        schoolNotes = "git@github.com:sudoneoox/2025FallUni";
      };

      #INFO: Paths that depend on identity
      homePath = "/home/${self.identity.username}";
      nixosConfPath = "${self.homePath}/Projects/nixos-config";
      nixosAssetsPath = "${self.homePath}/Assets/nixos-config";
      cachePath = "${self.homePath}/.cache";
      currentSchoolSemester = "2025FallUni";

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
          adguardHome = false;
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
          #TODO: add 1pass and 1pass-cli package
          "1password" = true;
          "reload-systemd-vconsole-setup" = true;
          rtkit = true;
          ssh = self.features.enableSSH;
          "systemd-ask-password-console" = true;
          systemd = true;
          tor = self.features.enableTor;
          usbguard = self.system.hostProfile == "laptop";
          user = true;
          "wpa-supplicant" = true;
          #TODO: Toggle on when finished with modules
          veracrypt = false;
        };
      };

      #INFO: Features (can depend on system.hostProfile)
      features = {
        enableNixcord = false;
        enableCachix = true;
        enableDocker = true;
        enableWinboat = true && self.features.enableDocker;
        enableWine = false;
        enableLibvirt = false;
        enableGaming = false;
        enablePrinting = self.system.hostProfile == "desktop";
        enableBluetooth = true;
        enableFlatpak = true;
        enableResilioSync = false;
        enableUdiskie = true;
        enableAudio = true;
        enableSSH = true;
        enableTor = self.system.hostProfile == "desktop";
        enableQbittorrent = true;
        enableHDR = false;
        enableCider = false;
        enableZram = true;
        # Run RStudio in Winboat, way better experience
        enableRStudio = false;
        # Just use the typst web app
        enableTypst = false;
        enableZed = false;
        #WARNING: This doesnt set up luks but rather the default boot.nix
        # you still have to setup luks on your own
        enableLuks = true;
        enableKDEConnect = false;
      };

      #INFO: Theming / UX
      ux = {
        font = "JetbrainsMono Nerd Font";
        defaultFont = "nerd-fonts.jetbrains-mono";
        fontPkgs = ["nerd-fonts.jetbrains-mono" "source-code-pro"];
        fontSize = 11.0;
        cursorTheme = "Posy_Cursor";
        cursorPkg = "posy-cursors";
        cursorSize = 24;
        gtkTheme = "Materia-dark";
        iconTheme = "Tela-black";
        qtStyle = "adwaita-dark";
        #NOTE: See modules/home/utils/Assets/wallpapers for options
        wallpaper = "cat_spectrum1.png";
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
        browser = "google-chrome-stable";
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
