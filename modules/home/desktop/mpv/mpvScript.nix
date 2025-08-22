{
  config,
  pkgs,
  ...
}: let
  mpvBin = "${config.programs.mpv.package}/bin/mpv";
in {
  # Two tiny helper binaries in your PATH
  home.packages = [
    (pkgs.writeShellScriptBin "mpv-intel" ''
      exec ${mpvBin} --profile=gpu-intel "$@"
    '')
    (pkgs.writeShellScriptBin "mpv-nvidia" ''
      # Use PRIME offload helper provided by nixos-hardware prime.nix
      if command -v nvidia-offload >/dev/null 2>&1; then
        exec nvidia-offload ${mpvBin} --profile=gpu-nvidia "$@"
      else
        # Fallback: export the usual PRIME env vars explicitly
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec ${mpvBin} --profile=gpu-nvidia "$@"
      fi
    '')
  ];

  # Optional: nice .desktop launchers so you can pick from app menus
  xdg.desktopEntries = {
    "mpv-intel" = {
      name = "MPV (Intel iGPU)";
      exec = "mpv-intel %U";
      terminal = false;
      type = "Application";
      categories = ["AudioVideo" "Player"];
    };
    "mpv-nvidia" = {
      name = "MPV (NVIDIA Offload)";
      exec = "mpv-nvidia %U";
      terminal = false;
      type = "Application";
      categories = ["AudioVideo" "Player"];
    };
  };

  # Optional: Hyprland keybinds to launch either profile
  # (Adjust to taste; this is just an example)
  # programs.hyprland.settings.bind = [
  #   "SUPER, I, exec, mpv-intel"
  #   "SUPER, N, exec, mpv-nvidia"
  # ];
}
