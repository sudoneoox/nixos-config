{
  pkgs,
  username,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.${username} = {
      hashedPasswordFile = config.sops.secrets."system-password".path;
      isNormalUser = true;
      description = "${username}";
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "networkmanager"
        "storage"
        "input"
      ];
      shell = pkgs.fish;
    };
  };
}
