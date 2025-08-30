{pkgs, ...}:
pkgs.writeShellApplication {
  name = "veracrypt-mount";
  runtimeInputs = with pkgs; [veracrypt util-linux coreutils gnugrep gawk];
  text = ''
    set -euo pipefail

    # Enable trace only if requested (set VC_DEBUG=1 in env)
    if [ "''${VC_DEBUG:-0}" = 1 ]
    then
      set -x
    else
      true
    fi

    # [ "''${VC_DEBUG:-0}" = "1" ] && set -x || true

    inst="''${1:-}"
    if [ -z "''${inst}" ]; then
      echo "usage: veracrypt-mount <instance>   (e.g., sda1)" >&2
      exit 64
    fi

    DEV="/dev/''${inst}"
    MP="''${VC_MNT_BASE:-/media/veracrypt}-''${inst}"

    # Systemd credential (preferred) or explicit override via VC_PASSFILE
    CRED_DIR="''${CREDENTIALS_DIRECTORY:-/run/credentials}"
    PASSFILE="''${VC_PASSFILE:-$CRED_DIR/vcpass}"

    # Sanity checks
    if [ ! -b "''${DEV}" ]; then
      echo "Device not found: ''${DEV}" >&2
      exit 2
    fi
    if [ ! -r "''${PASSFILE}" ]; then
      echo "Passfile not readable: ''${PASSFILE}" >&2
      exit 3
    fi

    # Guard: ensure we’re on the expected partition if VC_PARTUUID is provided
    if [ -n "''${VC_PARTUUID:-}" ]; then
      got="$(blkid -s PARTUUID -o value "''${DEV}" || true)"
      if [ "''${got}" != "''${VC_PARTUUID}" ]; then
        echo "PARTUUID mismatch for ''${DEV}: got=''${got} expected=''${VC_PARTUUID}" >&2
        exit 4
      fi
    fi

    mkdir -p "''${MP}"

    # Idempotency: skip if already mounted
    if mountpoint -q "''${MP}"; then
      echo "Already mounted at ''${MP}, skipping."
      exit 0
    fi

    # Mount options for ownership/permissions on FUSE mount
    # MOPTS="''${VC_MOUNT_OPTS:-uid=1000,gid=100,umask=0077}"

    # Do the mount
    exec veracrypt \
      --text --non-interactive --stdin \
      --mount "''${DEV}" "''${MP}" < "''${PASSFILE}"
  '';
}
