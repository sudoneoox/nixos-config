{ config, pkgs, username, email, ... }:
{
  users = {
    defaultUserShell = pkgs.zsh;
    users.${username} = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [ "wheel" "video" "audio" "networkmanager" "storage" "input" ];
      shell = pkgs.zsh;
    };
  };
}
