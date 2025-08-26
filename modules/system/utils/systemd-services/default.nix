{
  lib,
  custom_vars,
  ...
}: {
  imports =
    [
      ./sops-secrets-sync.nix
    ]
    ++ lib.optionals (custom_vars.COLOR_SCHEME == "wallust") [
      ./wallust-apply-current.nix
    ]
    ++ lib.optionals (custom_vars.SYSTEM.HOST_PROFILE == "laptop") [
      ./low-battery-notifier.nix
    ];
}
