{
  custom,
  lib,
  pkgs,
  ...
}: let
  x = custom.x0;
  laptopSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINKTZr4ziWc3egf/307wdW8rLgX054F/+XHgcpwZoeOp";
  desktopSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILazzw7Glpmu/Ix3GTjPyN76PwfHeqU4oGtz1WoIjuW0";
  signingKey =
    if x.derived.isLaptop
    then laptopSigningKey
    else desktopSigningKey;
  opSshSign = lib.getExe' pkgs._1password-gui "op-ssh-sign";
in {
  programs.git = {
    enable = true;
    settings = {
      user.name = "${x.identity.username}";
      user.email = "${x.identity.email}";
      extraConfig = {
        init.defaultBranch = "main";
        gpg.format = "ssh";
        "gpg \"ssh\"".program = opSshSign;
        commit.gpgSign = true;
        user.signingKey = signingKey;
      };
    };
  };
}
