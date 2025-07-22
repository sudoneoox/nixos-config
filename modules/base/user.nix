{ config, pkgs, username, email, ... }:
{

  programs.fish.enable = true;
  environment.shells = [ pkgs.bashInteractive pkgs.fish ];

  users = {
    defaultUserShell = pkgs.fish;
    users.${username} = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [ "wheel" "video" "audio" "networkmanager" "storage" "input"];
       shell = pkgs.fish;
    };
  };
}
