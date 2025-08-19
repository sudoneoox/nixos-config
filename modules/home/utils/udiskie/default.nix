{pkgs, ...}: {
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };
  home.packages = [pkgs.udiskie];
}
