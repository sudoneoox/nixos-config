{host, mkIf, ...}:
{
  imports = [
    lib.mkIf (host == "X0NixOSLaptop") [
      ./single-monitor.nix
    ];
    lib.mkIf (host == "X0NixOSDesktop") [
      ./multi-monitor.nix
    ]
  ];
}
