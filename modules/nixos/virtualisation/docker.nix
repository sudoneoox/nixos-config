{username, pkgs, ...}:
{
  virtualisation = {
      oci-containers.backend = true;
      docker.enable = true;
    };
  environment.systemPackages = with pkgs; [lazydocker];

  users.users.${username}.extraGroups = ["docker"];
} 
