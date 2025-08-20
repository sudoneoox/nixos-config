{custom_vars, ...}: {
  programs.git = {
    enable = true;
    userName = "${custom_vars.USERNAME}";
    userEmail = "${custom_vars.EMAIL}";
    signing = {
      key = "${custom_vars.SSH_KEY_PATH}";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgSign = true;
      gpg.format = "ssh";
    };
  };
}
