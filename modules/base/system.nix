{
  services.fwupd.enable = true;
  services.journald.extraConfig = ''
    SystemMaxUse=1G
    MaxFileSec=1month
  '';
  boot.loader.systemd-boot.configurationLimit = 10;
}
