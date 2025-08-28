{
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  imports =
    [
      ./sops-secrets-sync.nix
    ]
    ++ lib.optionals (config.x0.colorScheme == "wallust") [
      ./wallust-apply-current.nix
    ]
    ++ lib.optionals (config.x0.system.hostProfile == "laptop") [
      ./low-battery-notifier.nix
    ];
}
