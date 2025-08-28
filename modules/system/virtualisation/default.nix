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
    ++ lib.optionals x.features.enableDocker [
      ./docker.nix
    ]
    ++ lib.optionals x.features.enableWine [
      ./wine.nix
    ]
    ++ lib.optionals x.features.enableLibvirt
    [
      ./qemu.nix
    ];
}
