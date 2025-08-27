{
  pkgs,
  X0,
  ...
}: {
  lowBatteryNotifier = pkgs.callPackage ./scripts/low-battery-notifier.nix {};
  hyprRestoreWindow = pkgs.callPackage ./scripts/hypr-restore-window.nix {};
  wallustPick = pkgs.callPackage ./scripts/wallust-pick.nix {inherit X0;};
  wallustApplyCurrent = pkgs.callPackage ./scripts/wallust-apply-current.nix {inherit X0;};
  playerctlLock = pkgs.callPackage ./scripts/playerctl-lock.nix {};
  ciderLatest = pkgs.callPackage ./applications/cider-latest.nix {inherit X0;};
}
