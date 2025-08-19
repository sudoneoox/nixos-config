{
  pkgs,
  custom_vars,
  config,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.${custom_vars.USERNAME} = {
      hashedPasswordFile = config.sops.secrets."system-password".path;
      isNormalUser = true;
      description = "${custom_vars.USERNAME}";
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
