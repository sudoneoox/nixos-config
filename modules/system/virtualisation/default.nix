{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  imports =
    [
    ]
    ++ lib.optionals config.x0.features.enableDocker [
      ./docker.nix
    ]
    ++ lib.optionals config.x0.features.enableWine [
      ./wine.nix
    ]
    ++ lib.optionals config.x0.features.enableLibvirt
    [
      ./qemu.nix
    ];
}
