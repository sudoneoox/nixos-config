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

  # laptop | desktop
  HOST_PROFILE = "laptop";
  # nvidia
  GPU_VENDOR = "nvidia";

  # intel | amd
  CPU_VENDOR = "intel";
  # single | multi
  MONITORS = "single";
  SCALE = 1.0;
  PRIMARY_MONITOR = "eDP-1";

  #INFO: --- Feature flags (System Toggles) --- #
  ENABLE_DOCKER = false;
  ENABLE_WINE = false;
  ENABLE_LIBVIRT = false;
  ENABLE_GAMING = false;
  ENABLE_PRINTING = false;
  ENABLE_BLUETOOTH = true;
  ENABLE_FLATPAK = false;
  ENABLE_RESILIO_SYNC = false;
  ENABLE_UDISKIE = true;
  ENABLE_AUDIO = true;
  ENABLE_SSH = true;

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
  WALLPAPER = "glitch.png";
  COLOR_SCHEME = "wallust";

  #INFO: --- Paths for repo & assets --- #
  NIXOS_CONF_PATH = "${HOME_DIR}/Projects/nixos-config";
  NIXOS_ASSETS_PATH = "${HOME_DIR}/Assets/nixos-config";
  CACHE_PATH = "${HOME_DIR}/.cache";

  #INFO: --- Default Apps --- #
  TERMINAL = "kitty";
  BROWSER = "zen-browser-twilight";
  FILE_MANAGER = "thunar";
  EDITOR = "nvim";

  #INFO: --- Locale / Input --- #
  TIMEZONE = "America/Chicago";
  LOCALE = "en_US.UTF-8";
  KEYBOARD_LAYOUT = "us";
}
