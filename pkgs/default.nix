{
  pkgs,
  custom_vars,
  ...
}: {
  lowBatteryNotifier = pkgs.callPackage ./scripts/low-battery-notifier.nix {};
  hyprRestoreWindow = pkgs.callPackage ./scripts/hypr-restore-window.nix {};
  wallustPick = pkgs.callPackage ./scripts/wallust-pick.nix {inherit custom_vars;};
  nixUpdateChecker = pkgs.callPackage ./scripts/nix-update-checker.nix {inherit custom_vars;};
  wallustApplyCurrent = pkgs.callPackage ./scripts/wallust-apply-current.nix {inherit custom_vars;};
  playerctlLock = pkgs.callPackage ./scripts/playerctl-lock.nix {};
  ciderLatest = pkgs.callPackage ./cider-latest.nix {inherit custom_vars;};
}
