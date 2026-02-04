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
      kpcli # Keepass CLI
      # Encryption
      age
    ]
    ++ lib.optionals x.system.security.veracrypt [
      veracrypt
    ];
}
