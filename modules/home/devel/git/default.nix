{custom_vars, ...}: {
  programs.git = {
    enable = true;
    userName = "${custom_vars.USERNAME}";
    userEmail = "${custom_vars.EMAIL}";
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgSign = true;
      gpg.format = "ssh";
    };
  };
}
