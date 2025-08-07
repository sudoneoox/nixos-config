{host, lib, ...}:
{

  imports = [] 
    ++ lib.optional (host == "X0NixOSLaptop") ./single-monitor.nix
    ++ lib.optional (host == "X0NixOSDesktop") ./multi-monitor.nix;

}
