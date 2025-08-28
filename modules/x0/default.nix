# Accepts specialArg X0 (your original rec {}) OR imports ../../custom_vars.nix.
# Maps your original UPPERCASE fields into the typed options above. No fancy builders.
{X0 ? (import ../../custom_vars.nix), ...}: let
  old = X0; # your original file exactly as pasted
  normalized = {
    username = old.USERNAME;
    fullName = old.FULL_NAME or "";
    email = old.EMAIL or "";
    github = old.GITHUB or "";
    sshKeyPath = old.SSH_KEY_PATH or "";

    system = {
      hostProfile = old.SYSTEM.HOST_PROFILE;
      gpuVendor = old.SYSTEM.GPU_VENDOR;
      powerManagement = old.SYSTEM.POWER_MANAGEMENT;
      cpuVendor = old.SYSTEM.CPU_VENDOR;
      monitors = old.SYSTEM.MONITORS;
      scale = old.SYSTEM.SCALE;
      security = {
        acipd = old.SYSTEM.SECURITY.acipd;
        blacklistedModules = old.SYSTEM.SECURITY.blacklistedModules;
        bluetooth = old.SYSTEM.SECURITY.bluetooth;
        boot = old.SYSTEM.SECURITY.boot;
        cups = old.SYSTEM.SECURITY.cups;
        dbus = old.SYSTEM.SECURITY.dbus;
        doas = old.SYSTEM.SECURITY.doas;
        fail2ban = old.SYSTEM.SECURITY.fail2ban;
        getty = old.SYSTEM.SECURITY.getty;
        kernel = old.SYSTEM.SECURITY.kernel;
        network-manager = old.SYSTEM.SECURITY."network-manager";
        network-manager-dispatcher = old.SYSTEM.SECURITY."network-manager-dispatcher";
        nix-daemon = old.SYSTEM.SECURITY."nix-daemon";
        reload-systemd-vconsole-setup = old.SYSTEM.SECURITY."reload-systemd-vconsole-setup";
        rtkit = old.SYSTEM.SECURITY.rtkit;
        ssh = old.SYSTEM.SECURITY.ssh;
        systemd-ask-password-console = old.SYSTEM.SECURITY."systemd-ask-password-console";
        systemd = old.SYSTEM.SECURITY.systemd;
        tor = old.SYSTEM.SECURITY.tor;
        usbguard = old.SYSTEM.SECURITY.usbguard;
        user = old.SYSTEM.SECURITY.user;
        wpa-supplicant = old.SYSTEM.SECURITY."wpa-supplicant";
      };
    };

    features = {
      enableCachix = old.FEATURES.ENABLE_CACHIX;
      enableDocker = old.FEATURES.ENABLE_DOCKER;
      enableWine = old.FEATURES.ENABLE_WINE;
      enableLibvirt = old.FEATURES.ENABLE_LIBVIRT;
      enableGaming = old.FEATURES.ENABLE_GAMING;
      enablePrinting = old.FEATURES.ENABLE_PRINTING;
      enableBluetooth = old.FEATURES.ENABLE_BLUETOOTH;

      enableFlatpak = old.FEATURES.ENABLE_FLATPAK;
      enableResilioSync = old.FEATURES.ENABLE_RESILIO_SYNC;
      enableUdiskie = old.FEATURES.ENABLE_UDISKIE;
      enableAudio = old.FEATURES.ENABLE_AUDIO;
      enableSSH = old.FEATURES.ENABLE_SSH;
      enableTor = old.FEATURES.ENABLE_TOR;
      enableQbittorrent = old.FEATURES.ENABLE_QBITTORRENT;
      enableHDR = old.FEATURES.ENABLE_HDR;
      enableCider = old.FEATURES.ENABLE_CIDER;
      enableZram = old.FEATURES.ENABLE_ZRAM;
      enableRStudio = old.FEATURES.ENABLE_RSTUDIO;
      enableTypst = old.FEATURES.ENABLE_TYPST;
      enableZed = old.FEATURES.ENABLE_ZED;
    };

    # Theming / UX
    font = old.FONT;
    defaultFont = old.DEFAULT_FONT;
    fontPkgs = old.FONT_PKGS;

    fontSize = old.FONT_SIZE;
    cursorTheme = old.CURSOR_THEME;
    cursorSize = old.CURSOR_SIZE;
    gtkTheme = old.GTK_THEME;
    iconTheme = old.ICON_THEME;
    qtStyle = old.QT_STYLE;
    wallpaper = old.WALLPAPER;
    colorScheme = old.COLOR_SCHEME;
    de = old.DE;

    # Paths / keys
    nixosConfPath = old.NIXOS_CONF_PATH;
    nixosAssetsPath = old.NIXOS_ASSETS_PATH;
    cachePath = old.CACHE_PATH;
    sopsPath = old.SOPS_PATH;
    sopsPublicKey = old.SOPS_PUBLIC_KEY;

    # Apps
    terminal = old.TERMINAL;
    ide = old.IDE;
    browser = old.BROWSER;
    fileManager = old.FILE_MANAGER;
    editor = old.EDITOR;

    # Locale
    timezone = old.TIMEZONE;
    locale = old.LOCALE;
    keyboardLayout = old.KEYBOARD_LAYOUT;
  };
in {
  imports = [./options.nix ./derived.nix];
  config.x0 = normalized;
}
