{
  pkgs,
  custom,
  config,
  lib,
  ...
}: let
  veracryptPartUUID = "bc726c0b-01"; # sda1 PARTUUID
  mntBase = "/media/veracrypt";
  x = custom.x0;
in {
  systemd.services."veracrypt-auto@" = lib.mkIf (x.system.security.veracrypt && x.features.enableUdiskie) {
    description = "Auto-unlock and mount VeraCrypt device %I";
    after = ["local-fs.target"];

    serviceConfig = {
      Type = "oneshot";

      # Provide the pass via systemd-credentials
      LoadCredential = ["vcpass:${config.sops.secrets."veracrypt-pass".path}"];

      Environment = [
        "VC_PARTUUID=${veracryptPartUUID}"
        "VC_MNT_BASE=${mntBase}"
        "VC_DEBUG=1"
        "SYSTEMD_LOG_LEVEL=debug"
      ];

      # pass instance name into script (so it becomes $1 inside)
      ExecStart = "${pkgs.veracrypt-mount}/bin/veracrypt-mount %i";

      StandardOutput = "journal+console";
      StandardError = "journal+console";
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd*[0-9]", \
      ENV{ID_PART_ENTRY_UUID}=="${veracryptPartUUID}", \
      TAG+="systemd", ENV{SYSTEMD_WANTS}="veracrypt-auto@%k.service"
  '';
}
