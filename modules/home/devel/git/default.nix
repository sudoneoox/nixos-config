{custom, ...}: let
  x = custom.x0;
in {
  programs.git = {
    enable = true;
    settings = {
      user.name = "${x.identity.username}";
      user.email = "${x.identity.email}";
      signing = {
        key = "${x.identity.sshKeyPath}";
        signByDefault = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        commit.gpgSign = true;
        gpg.format = "ssh";
      };
    };
  };
}
