{
  pkgs,
  username,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
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
