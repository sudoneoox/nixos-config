{
  lib,
  custom_vars,
  ...
}: {
  imports =
    [
      ./font.nix
      ./nh.nix
      ./nix.nix
      ./nixpkgs.nix
      ./overlays.nix
      ./sops.nix
      ./substituters.nix
      ./system.nix
      ./user.nix
      ./hardware/fstrim.nix
      ./hardware/thermald.nix
      ./hardware/locale.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_BLUETOOTH [
      ./hardware/bluetooth.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_UDISKIE [
      ./hardware/udisks.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_AUDIO [
      ./hardware/audio.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_PRINTING
    [
      ./hardware/printing.nix
    ]
    ++ lib.optionals (custom_vars.HOST_PROFILE == "laptop") [
      ./hardware/libinput.nix
      ./hardware/powerManagement.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_RESILIO_SYNC [
      ./resilio.nix
    ]
    ++ lib.optionals custom_vars.ENABLE_SSH [
      ./hardware/ssh.nix
    ];
}
