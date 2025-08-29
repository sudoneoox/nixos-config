{
  pkgs,
  custom,
  ...
}: let
  x = custom.x0;
  lowBatteryNotifier = pkgs.callPackage ../../../../pkgs/scripts/low-battery-notifier.nix {
    isLaptop = x.derived.isLaptop;
  };
  wallustApplyCurrent = pkgs.callPackage ../../../../pkgs/scripts/wallust-apply-current.nix {
    colorScheme = x.ux.colorScheme;
    nixosAssetsPath = x.nixosAssetsPath;
    wallpaper = x.ux.wallpaper;
    cachePath = x.cachePath;
  };
  wallustPick = pkgs.callPackage ../../../../pkgs/scripts/wallust-pick.nix {
    nixosAssetsPath = x.nixosAssetsPath;
    cachePath = x.cachePath;
  };
  hyprRestoreWindow = pkgs.callPackage ../../../../pkgs/scripts/hypr-restore-window.nix {};
  playerctlLock = pkgs.callPackage ../../../../pkgs/scripts/playerctl-lock.nix {};
in {
  # WARN: defined in pkgs/scripts and overlayed in overlays/default.nix
  environment.systemPackages = with pkgs; [
    lowBatteryNotifier
    wallustPick
    hyprRestoreWindow
    wallustApplyCurrent
    playerctlLock
  ];
}
