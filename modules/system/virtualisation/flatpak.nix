#NOTE: remember to
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
{
  lib,
  custom,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableFlatpak {
    services.flatpak.enable = true;
  };
}
