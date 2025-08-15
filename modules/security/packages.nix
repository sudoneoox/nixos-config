{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lynis
    clamav
    proton-pass # password manager
    protonvpn-gui # vpn
  ];
}
