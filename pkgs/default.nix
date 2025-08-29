{
  pkgs,
  custom,
  ...
}: {
  lowBatteryNotifier = pkgs.callPackage ./scripts/low-battery-notifier.nix {inherit custom;};
  hyprRestoreWindow = pkgs.callPackage ./scripts/hypr-restore-window.nix {};
  wallustPick = pkgs.callPackage ./scripts/wallust-pick.nix {inherit custom;};
  wallustApplyCurrent = pkgs.callPackage ./scripts/wallust-apply-current.nix {inherit custom;};
  playerctlLock = pkgs.callPackage ./scripts/playerctl-lock.nix {};
  ciderLatest = pkgs.callPackage ./applications/cider-latest.nix {inherit custom;};
}
