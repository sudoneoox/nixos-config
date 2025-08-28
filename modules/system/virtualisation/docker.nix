{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };
  environment.systemPackages = with pkgs; [lazydocker];

  users.users.${config.x0.username}.extraGroups = ["docker"];
}
