{
  # All have enable options except packages.nix e.g.:
  # custom.x0.system.security.<module>.enable ?=
  imports = [
    ./1password.nix
    ./acipd.nix
    ./adguardHome.nix
    ./blacklistedModules.nix
    ./bluetooth.nix
    ./boot.nix
    ./cups.nix
    ./dbus.nix
    ./doas.nix
    ./fail2ban.nix
    ./getty.nix
    ./kernel-security.nix
    ./network-manager.nix
    ./network-manager-dispatcher.nix
    ./nix-daemon.nix
    ./packages.nix
    ./reload-systemd-vconsole-setup.nix
    ./rtkit.nix
    ./ssh.nix
    ./systemd-ask-password-console.nix
    ./systemd.nix
    ./tor.nix
    ./usb-protection.nix
    ./user.nix
    ./wpa_supplicant.nix
  ];
}
