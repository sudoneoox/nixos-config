{
  pkgs,
  config,
  ...
}: {
  services.spice-vdagentd.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  systemd.user.services.spice-vdagent-client = {
    description = "spice-vdagent client";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "on-failure";
      RestartSec = "5";
    };
  };

  programs.virt-manager.enable = true;
  security.polkit.enable = true;

  users.users.${config.x0.username}.extraGroups = ["libvirtd"];

  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    spice-vdagent
    swtpm
  ];
}
