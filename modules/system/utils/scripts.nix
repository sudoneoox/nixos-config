{
  pkgs,
  custom,
  ...
}: let
  x = custom.x0;
in {
  # WARN: defined in pkgs/scripts and overlayed in overlays/default.nix
  environment.systemPackages = with pkgs;
    [
      hyprRestoreWindow
      playerctlLock
    ]
    ++ lib.optionals x.derived.isLaptop [
      lowBatteryNotifier
    ]
    ++ lib.optionals (x.ux.colorScheme == "wallust") [
      wallustPick
      wallustApplyCurrent
    ]
    ++ lib.optionals (x.system.security.veracrypt && x.features.enableUdiskie) [
      veracrypt-mount
    ];
}
