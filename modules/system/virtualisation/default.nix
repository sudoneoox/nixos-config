{
  custom_vars,
  lib,
  ...
}: {
  imports =
    [
    ]
    ++ lib.optionals custom_vars.ENABLE_DOCKER [
      ./docker.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_WINE [
      ./wine.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_LIBVIRT
    [
      ./qemu.nix
    ];
}
