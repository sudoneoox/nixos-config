{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.accept-flake-config = true;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    fish
    bash
    git
    disko
    jq
    helix
    nano
  ];

  # Put your repo (or a subset) onto the ISO under /etc/nixos
  # This embeds sources from *this checkout* at build time.
  environment.etc."nixos/flake.nix".source = ../../flake.nix;
  environment.etc."nixos/flake.lock".source = ../../flake.lock;

  # Include just hosts + modules + lib + overlays + pkgs (your core structure)
  environment.etc."nixos/hosts".source = ../../hosts;
  environment.etc."nixos/modules".source = ../../modules;
  environment.etc."nixos/lib".source = ../../lib;
  environment.etc."nixos/overlays".source = ../../overlays;
  environment.etc."nixos/pkgs".source = ../../pkgs;

  # (Optional) a helper script to reduce typing (still doesn’t auto-wipe)
  environment.etc."nixos/x0-install.sh".text = ''
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Targets:"
    echo "  1) X0NixOSDesktop"
    echo "  2) X0NixOSLaptop"
    read -rp "Choose (1/2): " choice

    case "$choice" in
      1) host="X0NixOSDesktop" ;;
      2) host="X0NixOSLaptop" ;;
      *) echo "Invalid choice"; exit 1 ;;
    esac

    echo
    echo "Disks available:"
    lsblk
    echo
    read -rp "Type the disk path to wipe (example: /dev/nvme0n1): " disk

    echo
    echo "About to run Disko for $host and wipe: $disk"
    read -rp "Type WIPE to confirm: " confirm
    [ "$confirm" = "WIPE" ] || { echo "Aborting."; exit 1; }

    cd /etc/nixos

    # IMPORTANT: Your disk-configs hardcode device = "/dev/nvme0n1" currently.
    # This script expects that matches your target disk.
    disko --mode disko ./hosts/$host/disk-config.nix

    nixos-install --flake /etc/nixos#$host
    echo "Done. Reboot when ready."
  '';
  systemd.tmpfiles.rules = [
    "f /etc/nixos/x0-install.sh 0755 root root - -"
  ];

  isoImage.volumeID = "X0-NixOS-Installer";
}
