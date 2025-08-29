{
  config,
  pkgs,
  custom,
  ...
}: let
  x = custom.x0;
in {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.${x.identity.username} = {
      hashedPasswordFile = config.sops.secrets."system-password".path;
      isNormalUser = true;
      description = "${x.identity.username}";
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
