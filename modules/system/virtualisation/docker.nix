{
  custom_vars,
  pkgs,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };
  environment.systemPackages = with pkgs; [lazydocker];

  users.users.${custom_vars.USERNAME}.extraGroups = ["docker"];
}
