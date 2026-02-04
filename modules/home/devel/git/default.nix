{
  custom,
  lib,
  pkgs,
  ...
}: let
  x = custom.x0;
in {
  programs.git = {
    enable = true;
    settings = {
      user.name = "${x.identity.username}";
      user.email = "${x.identity.email}";
      extraConfig = {
        init.defaultBranch = "main";
        gpg.format = "ssh";
        "gpg \"ssh\"" = lib.mkIf x.system.security."1password" {
          program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        };
        commit.gpgSign = true;
        user.signingKey =
          lib.mkIf x.system.security."1password"
          "...";
      };
    };
  };
}
