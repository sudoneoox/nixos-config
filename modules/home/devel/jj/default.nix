{custom, ...}: let
  x = custom.x0;
in {
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = x.identity.username;
      user.email = x.identity.email;
      ui = {
        color = "auto";
        movement = {edit = true;};
      };
      colors = {
        commit_id = "green";
        "diff token" = {
          reverse = true;
          underline = false;
        };
        "working copy commid_id" = {underline = true;};
      };
    };
  };
}
