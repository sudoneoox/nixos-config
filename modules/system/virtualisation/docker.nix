{
  config,
  pkgs,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableDocker {
    virtualisation = {
      docker.enable = true;
      oci-containers.backend = "docker";
    };
    environment.systemPackages = with pkgs; [lazydocker];

    users.users.${x.identity.username}.extraGroups = ["docker"];
  };
}
