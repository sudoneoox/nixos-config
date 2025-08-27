rec {
  #INFO: --- Identity --- #
  USERNAME = "diego";
  FULL_NAME = "Diego Coronado";
  EMAIL = "diegoa2992@proton.me";
  GITHUB = "sudoneoox";
  SSH_KEY_PATH = "/home/${USERNAME}/.ssh/id_ed25519.pub";

  #NOTE: Derive once, reuse everywhere (don't use "~" — Nix won't expand it)
  HOME_DIR = "/home/${USERNAME}";

  #--#INFO: --- Host / Profile --- #
  SYSTEM = {
    # laptop | desktop
    HOST_PROFILE = "desktop";
    # nvidia
    GPU_VENDOR = "nvidia";

    # intel | amd
    CPU_VENDOR =
      if (SYSTEM.HOST_PROFILE == "laptop")
      then "intel"
      else "amd";

    # single | multi
    MONITORS =
      if (SYSTEM.HOST_PROFILE == "laptop")
      then "single"
      else "multi";

    SCALE = "1.00";

    PRIMARY_MONITOR =
      if (SYSTEM.HOST_PROFILE == "laptop")
      then "eDP-1"
      else null;
  };

  #INFO: --- Feature flags (System Toggles) --- #
  FEATURES = {
    ENABLE_CACHIX = true;
    ENABLE_DOCKER = false;
    ENABLE_WINE = false;
    ENABLE_LIBVIRT = false;
    ENABLE_GAMING = false;
    ENABLE_PRINTING =
      if (SYSTEM.HOST_PROFILE == "laptop")
      then false
      else true;
    ENABLE_BLUETOOTH =
      if (SYSTEM.HOST_PROFILE == "laptop")
      then false
      else true;
    ENABLE_FLATPAK = false;
    ENABLE_RESILIO_SYNC = true;
    ENABLE_UDISKIE = true;
    ENABLE_AUDIO = true;
    ENABLE_SSH = true;
    ENABLE_TOR = false;
    ENABLE_QBITTORRENT = false;
    # specifically for wayland->hyprland
    ENABLE_HDR = false;
    ENABLE_CIDER = false;
    ENABLE_ZRAM = true;
    ENABLE_RSTUDIO = true;
  };

  #INFO: --- Theming / UX --- #
  FONT = "JetbrainsMono Nerd Font";
  DEFAULT_FONT = "pkgs.nerd-fonts.jetbrains-mono";
  FONT_PKGS = [
    "nerd-fonts.jetbrains-mono"
    "nerd-fonts.fira-code"
    "source-code-pro"
  ];

  FONT_SIZE = 11.0;
  CURSOR_THEME = "macOS";
  CURSOR_SIZE = 24;
  GTK_THEME = "Materia-dark";
  ICON_THEME = "Tela-black";
  QT_STYLE = "adwaita-dark";
  #NOTE: See modules/home/utils/Assets/wallpapers for options
  WALLPAPER = "nordic.png";
  # only option
  COLOR_SCHEME = "wallust";
  DE = "hyprland";

  #INFO: --- Paths and keys for repo & assets --- #
  NIXOS_CONF_PATH = "${HOME_DIR}/Projects/nixos-config";
  NIXOS_ASSETS_PATH = "${HOME_DIR}/Assets/nixos-config";
  CACHE_PATH = "${HOME_DIR}/.cache";
  SOPS_PATH = "/var/lib/sops-nix";
  SOPS_PUBLIC_KEY = "age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2";

  #INFO: --- Default Apps --- #
  TERMINAL = "kitty";
  IDE = "zed";
  BROWSER = "zen-browser-twilight";
  FILE_MANAGER = "thunar";
  EDITOR = "nvim";

  #INFO: --- Locale / Input --- #
  TIMEZONE = "America/Chicago";
  LOCALE = "en_US.UTF-8";
  KEYBOARD_LAYOUT = "us";
}
