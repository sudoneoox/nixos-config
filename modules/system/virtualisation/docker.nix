{
  config,
  pkgs,
  ...
}: let
  x = config.x0;
in {
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };
  environment.systemPackages = with pkgs; [lazydocker];

  users.users.${x.username}.extraGroups = ["docker"];
}
