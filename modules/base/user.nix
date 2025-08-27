{
  pkgs,
  X0,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.${X0.USERNAME} = {
      hashedPasswordFile = config.sops.secrets."system-password".path;
      isNormalUser = true;
      description = "${X0.USERNAME}";
      extraGroups = [
        "wheel"
        "video"
        "storage"
        "input"
      ];
      shell = pkgs.fish;
    };
  };
}
