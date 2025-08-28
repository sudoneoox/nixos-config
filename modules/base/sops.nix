# WARN: check modules/system/utils/systemd-services/sops-secrets-sync.nix
{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  x = config.x0;
  SOPS_PUBLIC_KEY = x.sopsPublicKey;
  SOPS_KEY_FILE = "${x.sopsPath}/key.txt";
  SOPS_SECRETS_PATH = "${x.sopsPath}/secrets";
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  #INFO: Ensure the secrets dir exists with strict perms
  systemd.tmpfiles.rules = [
    "d ${x.sopsPath} 0700 root root -"
    "d ${SOPS_SECRETS_PATH} 0700 root root -"
  ];

  sops = {
    # INFO: since our keyfile is outside of /nix/store
    validateSopsFiles = false;
    age = {
      # place generated key file here for secrets
      # sudo install -m 0400 -o root -g root key.txt /var/lib/sops-nix/key.txt
      keyFile = SOPS_KEY_FILE;
      # We generate it ourself
      generateKey = false;
    };
    # defaultSopsFile = ../../hosts/common/secrets.enc.yaml;
    defaultSopsFile = "${SOPS_SECRETS_PATH}/secrets.enc.yaml";
    secrets = {
      # NOTE: These use the defaultSopsFile
      "wireless.env" = {
        owner = "root";
      };
      "system-password" = {
        owner = "root";
        neededForUsers = true;
      };
    };
  };

  # NOTE: Have these for the systemd services to function
  environment.systemPackages = with pkgs; [sops git];

  # INFO: useful for easy decryption and encryption
  environment.variables = {
    SOPS_AGE_KEY_FILE = SOPS_KEY_FILE;
    SOPS_AGE_RECIPIENTS = SOPS_PUBLIC_KEY;
  };

  programs.ssh.knownHosts.github = lib.mkIf config.x0.features.enableSsh {
    hostNames = ["github.com"];
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
  };
}
