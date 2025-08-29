{pkgs, ...}: {
  # WARN: defined in pkgs/scripts and overlayed in overlays/default.nix
  environment.systemPackages = with pkgs; [
    lowBatteryNotifier
    wallustPick
    hyprRestoreWindow
    wallustApplyCurrent
    playerctlLock
  ];
}
