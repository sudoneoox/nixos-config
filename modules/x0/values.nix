{
  # identity
  username = "diego";
  fullName = "Diego Coronado";
  email = "diegoa2992@proton.me";
  github = "sudoneoox";
  sshKeyPath = "/home/diego/.ssh/id_ed25519.pub";

  # system/profile (raw knobs; derived.nix computes the *Eff flags)
  system = {
    hostProfile = "desktop"; # "laptop" | "desktop"
    gpuVendor = "nvidia"; # "intel" | "amd" | "nvidia"
    powerManagement = false; # laptop overrides it via derived
    cpuVendor = "amd"; # laptop -> "intel" via derived
    monitors = "multi"; # laptop -> "single" via derived
    scale = "1.00";
    security = {
      acipd = true;
      blacklistedModules = true;
      bluetooth = true; # pairs with features.enableBluetooth
      boot = true;
      cups = true; # pairs with features.enablePrinting
      dbus = true;
      doas = true;
      fail2ban = true; # pairs with features.enableSSH
      getty = true;
      kernel = true;
      network-manager = true;
      network-manager-dispatcher = true;
      nix-daemon = false;
      reload-systemd-vconsole-setup = true;
      rtkit = true;
      ssh = true; # pairs with features.enableSSH
      systemd-ask-password-console = true;
      systemd = true;
      tor = false; # pairs with features.enableTor
      usbguard = true;
      user = true;
      wpa-supplicant = true;
    };
  };

  # features
  features = {
    enableCachix = true;
    enableDocker = false;
    enableWine = false;
    enableLibvirt = false;
    enableGaming = false;
    enablePrinting = true; # desktop default
    enableBluetooth = true; # desktop default

    enableFlatpak = false;
    enableResilioSync = true;
    enableUdiskie = true;
    enableAudio = true;
    enableSSH = true;
    enableTor = false;
    enableQbittorrent = false;
    enableHDR = false;
    enableCider = false;
    enableZram = true;
    enableRStudio = false;
    enableTypst = true;
    enableZed = false;
  };

  # theming / UX
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

  # paths / keys
  nixosConfPath = "/home/diego/Projects/nixos-config";
  nixosAssetsPath = "/home/diego/Assets/nixos-config";
  cachePath = "/home/diego/.cache";
  sopsPath = "/var/lib/sops-nix";
  sopsPublicKey = "age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2";

  # apps
  terminal = "kitty";
  ide = "zed";
  browser = "zen-browser-twilight";
  fileManager = "thunar";
  editor = "nvim";

  # locale
  timezone = "America/Chicago";
  locale = "en_US.UTF-8";
  keyboardLayout = "us";
}
