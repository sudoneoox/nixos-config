{config, ...}: let
  x = config.x0;
in {
  programs.git = {
    enable = true;
    userName = "${x.username}";
    userEmail = "${x.email}";
    signing = {
      key = "${config.xo.sshKeyPath}";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgSign = true;
      gpg.format = "ssh";
    };
  };
}
