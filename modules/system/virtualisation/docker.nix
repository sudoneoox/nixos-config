{
  username,
  pkgs,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };
  environment.systemPackages = with pkgs; [lazydocker];

  users.users.${username}.extraGroups = ["docker"];
}
