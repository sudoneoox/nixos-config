{ pkgs, username, ... }:
{
  users = {
    defaultUserShell = pkgs.fish;
    users.${username} = {
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
