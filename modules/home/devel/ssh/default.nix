{
  pkgs,
  custom,
  lib,
  config,
  ...
}: let
  x = custom.x0;
  onePassSock = "${config.home.homeDirectory}/.1password/agent.sock";
in {
  config = lib.mkIf x.features.enableSSH {
    programs.ssh = {
      enable = true;

      extraConfig = lib.mkIf x.system.security."1password" ''
        Host *
          IdentityAgent ${onePassSock}
      '';
    };
  };
}
