{
  pkgs,
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  environment.systemPackages = with pkgs;
    [
      lynis
      clamav
      proton-pass # password manager
      protonvpn-gui # vpn
      # Encryption
      age
    ]
    ++ lib.optionals x.system.security.veracrypt [
      veracrypt
    ];
}
