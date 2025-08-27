{
  X0,
  pkgs,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };
  environment.systemPackages = with pkgs; [lazydocker];

  users.users.${X0.USERNAME}.extraGroups = ["docker"];
}
