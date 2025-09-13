{
  pkgs,
  custom,
  ...
}: let
  x = custom.x0;
in {
  programs.adb.enable = true; # adds proper udev rules for many vendors incl. Google

  users.users.${x.identity.username}.extraGroups = ["adbusers"];

  environment.systemPackages = with pkgs; [android-tools];
}
