{
  config,
  custom,
  pkgs,
  lib,
  ...
}: let
  # Mount Point for unencrypted drive
  mntBase = "/media/veracrypt";
  x = custom.x0;
  #WARN: run; udevadm info --atribute-walk --name /dev/<device> and copy and replace the value below
  # ID_SERIAL_SHORT
in {
  # Template systemd unit: veracrypt-auto@<kernel-name>.service
  systemd.services."veracrypt-auto@" = lib.mkif (x.system.security.veracrypt && x.featuers.enableUdiskie) {
    description = "Auto-unlock and mount VeraCrypt device %I";
    after = ["local-fs.target"];
    serviceConfig = {
      Type = "oneshot";

      # Pass the sops secret to the unit as a systemd credential "vcpass"
      LoadCredential = [
        "vcpass:${config.sops.secrets."veracrypt-pass".path}"
      ];

      ExecStart = pkgs.writeShellScript "veracrypt-auto" ''
        set -eu
        DEV="/dev/%I"
        CRED_DIR="''${CREDENTIALS_DIRECTORY:-/run/credentials}"
        PASSFILE="$CRED_DIR/''${SYSTEMD_UNIT##*/}.vcpass"  # systemd maps LoadCredential to a file here

        # Fallback if systemd's mapped filename differs:
        [ ! -f "$PASSFILE" ] && PASSFILE="$CRED_DIR/vcpass"

        # Mountpoint derived from device name
        MP="${mntBase}-%I"
        mkdir -p "$MP"

        # Use stdin for the passphrase; non-interactive CLI
        # (Avoids exposing the password via argv/env)
        ${pkgs.veracrypt}/bin/veracrypt \
          --text --non-interactive --stdin \
          --mount "$DEV" "$MP" < "$PASSFILE"
      '';
    };
  };

  # Udev rule to start the template unit for your SSD partition.
  # Replace the matcher with your device’s identifiers (see notes below).
  services.udev.extraRules = ''
    # Example: trigger when /dev/sdX1 with a specific ID_SERIAL_SHORT appears
    ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd*[0-9]", ENV{ID_SERIAL_SHORT}=="<YOUR_DRIVE_SERIAL>", \
      TAG+="systemd", ENV{SYSTEMD_WANTS}="veracrypt-auto@%k.service"
  '';
}
