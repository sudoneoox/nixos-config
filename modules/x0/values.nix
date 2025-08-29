# NOTE:  (PLAIN ATTRSET — no config.*)
rec {
  #INFO: identity
  homePath = "/home/${identity.username}";

  identity = {
    username = "diego";
    fullName = "Diego Coronado";
    email = "diegoa2992@proton.me";
    github = "sudoneoox";
    sshKeyPath = "${identity.username}/.ssh/id_ed25519.pub";
  };

  #INFO: system/profile (raw knobs; derived computes *Eff)
  #NOTE: for derivations check out ./schema.nix
  system = {
    hostProfile = "desktop"; # "laptop" | "desktop"
    gpuVendor = "nvidia"; # "intel" | "amd" | "nvidia"
    powerManagement = false; # laptop overrides via derived
    cpuVendor = "amd"; # laptop -> "intel" via derived
    monitors = "multi"; # laptop -> "single" via derived
    scale = "1.00";
    security = {
      acipd = true;
      blacklistedModules = true;
      bluetooth = features.enableBluetooth;
      boot = true;
      cups = features.enablePrinting;
      dbus = true;
      doas = true;
      fail2ban = features.enableSSH;
      getty = true;
      kernel = true;
      "network-manager" = true;
      "network-manager-dispatcher" = true;
      #WARN: Gives Issues with rebuilding
      "nix-daemon" = false;
      "reload-systemd-vconsole-setup" = true;
      rtkit = true;
      ssh = features.enableSSH;
      "systemd-ask-password-console" = true;
      systemd = true;
      tor = features.enableTor;
      usbguard = true;
      user = true;
      "wpa-supplicant" = true;
    };
  };

  #INFO: features
  features = {
    enableCachix = true;
    enableDocker = false;
    enableWine = false;
    enableLibvirt = false;
    enableGaming = false;
    enablePrinting = system.hostProfile == "desktop";
    enableBluetooth = true;
    enableFlatpak = false;
    enableResilioSync = true;
    enableUdiskie = true;
    enableAudio = true;
    enableSSH = true;
    enableTor = system.hostProfile == "desktop";
    enableQbittorrent = false;
    enableHDR = false;
    enableCider = system.hostProfile == "desktop";
    enableZram = true;
    enableRStudio = false;
    enableTypst = true;
    enableZed = false;
  };

  #INFO: theming / UX
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

  #INFO: paths / keys
  nixosConfPath = "${identity.username}/Projects/nixos-config";
  nixosAssetsPath = "${identity.username}/Assets/nixos-config";
  cachePath = "${identity.username}/.cache";
  sopsPath = "/var/lib/sops-nix";
  sopsPublicKey = "age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2";

  #INFO: apps
  apps = {
    terminal = "kitty";
    ide = "zed";
    browser = "zen-twilight";
    fileManager = "thunar";
    editor = "nvim";
  };

  #INFO: locale
  timezone = "America/Chicago";
  locale = "en_US.UTF-8";
  keyboardLayout = "us";
}
