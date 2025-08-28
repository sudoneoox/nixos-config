{
  lib,
  config,
  ...
}: let
  X0 = import ../../custom_vars.nix; # your existing file for values today
in {
  imports = [./options.nix];

  config.x0 = {
    username = X0.USERNAME;
    colorScheme = X0.COLOR_SCHEME or "wallust";
    cursorSize = X0.CURSOR_SIZE or 26;

    system = {
      hostProfile = X0.SYSTEM.HOST_PROFILE;
      cpuVendor = X0.SYSTEM.CPU_VENDOR;
      gpuVendor = X0.SYSTEM.GPU_VENDOR;
      monitors = X0.SYSTEM.MONITORS;
      scale = X0.SYSTEM.SCALE;
      security = X0.SYSTEM.SECURITY or {};
    };

    features = {
      gaming = X0.FEATURES.ENABLE_GAMING or false;
      docker = X0.FEATURES.ENABLE_DOCKER or false;
      libvirt = X0.FEATURES.ENABLE_LIBVIRT or false;
      wine = X0.FEATURES.ENABLE_WINE or false;
      udiskie = X0.FEATURES.ENABLE_UDISKIE or false;
      audio = X0.FEATURES.ENABLE_AUDIO or true;
      bluetooth = X0.FEATURES.ENABLE_BLUETOOTH or true;
    };

    paths.cache = X0.CACHE_PATH or "/tmp";
    paths.assets = X0.NIXOS_ASSETS_PATH or "/etc/assets";

    font.family = X0.FONT or "JetBrainsMono Nerd Font";
    font.size = X0.FONT_SIZE or 10;
  };
}
