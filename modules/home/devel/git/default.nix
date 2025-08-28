{config, ...}: {
  programs.git = {
    enable = true;
    userName = "${config.x0.username}";
    userEmail = "${config.x0.email}";
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
