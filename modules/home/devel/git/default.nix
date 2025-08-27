{X0, ...}: {
  programs.git = {
    enable = true;
    userName = "${X0.USERNAME}";
    userEmail = "${X0.EMAIL}";
    signing = {
      key = "${X0.SSH_KEY_PATH}";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgSign = true;
      gpg.format = "ssh";
    };
  };
}
