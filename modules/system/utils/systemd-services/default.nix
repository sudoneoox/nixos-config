{
  lib,
  X0,
  ...
}: {
  imports =
    [
      ./sops-secrets-sync.nix
    ]
    ++ lib.optionals (X0.COLOR_SCHEME == "wallust") [
      ./wallust-apply-current.nix
    ]
    ++ lib.optionals (X0.SYSTEM.HOST_PROFILE == "laptop") [
      ./low-battery-notifier.nix
    ];
}
