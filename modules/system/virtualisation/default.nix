{
  custom_vars,
  lib,
  ...
}: {
  imports =
    [
    ]
    ++ lib.optionals custom_vars.FEATURES.ENABLE_DOCKER [
      ./docker.nix
    ]
    ++ lib.optionals custom_vars.FEATURES.ENABLE_WINE [
      ./wine.nix
    ]
    ++ lib.optionals custom_vars.FEATURES.ENABLE_LIBVIRT
    [
      ./qemu.nix
    ];
}
