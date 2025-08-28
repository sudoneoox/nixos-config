{
  pkgs,
  config,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.${config.x0.username} = {
      hashedPasswordFile = config.sops.secrets."system-password".path;
      isNormalUser = true;
      description = "${config.x0.username}";
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
