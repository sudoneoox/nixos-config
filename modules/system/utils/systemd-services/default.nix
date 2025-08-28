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
    ++ lib.optionals (x.colorScheme == "wallust") [
      ./wallust-apply-current.nix
    ]
    ++ lib.optionals (x.system.hostProfile == "laptop") [
      ./low-battery-notifier.nix
    ];
}
