Nixos Config

==================== Installation Guide ====================

1) Enter Root Shell

sudo -i

2) Clone Configuration

git clone https://github.com/sudoneoox/nixos-config cd
nixos-config/hosts/{host}/

If using LUKS encryption, follow this guide:
https://saylesss88.github.io/installation/enc/enc_install.html

IMPORTANT: Make sure you set the correct disk inside:
hosts/{host}/disk-config.nix

3) Run Disko and Generate Hardware Config

After running disko and mounting to /mnt:

nixos-generate-config –no-filesystems –root /mnt

cd /mnt/etc/nixos

4) Move Hardware Config + Repo

mv hardware-configuration.nix ~/nixos-config/hosts/{host}/hardware.nix
mv ~/nixos-config /mnt/etc/nixos

5) Install System

nixos-install –flake /mnt/etc/nixos/flake#{host}

6) SOPS Notice

The nix requirement comes from: modules/base/sops.nix

You must either: - Remove this module OR - Properly configure sops for
your system

7) Create SOPS Keyfile (Required Before First Boot)

echo {private-key} > private-key.txt

mkdir -p /var/lib/sops-nix

install -m 0400 -o root -g root private-key.txt
/var/lib/sops-nix/key.txt

8) Clone Secrets Repository

git clone https://github.com/sudoneoox/{your-secrets-repo}
/var/lib/sops-nix/secrets

9) Reboot

reboot

Installation complete.
