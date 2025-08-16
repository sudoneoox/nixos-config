# WARN: check modules/system/utils/systemd-services/sops-secrets-sync.nix
{
  inputs,
  pkgs,
  ...
}: let
  SOPS_PUBLIC_KEY = "age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2";
  SOPS_KEY_FILE = "/var/lib/sops-nix/key.txt";
  SOPS_SECRETS_PATH = "/var/lib/sops-nix/secrets";
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  #INFO: Ensure the secrets dir exists with strict perms
  systemd.tmpfiles.rules = [
    "d /var/lib/sops-nix 0700 root root -"
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
      "wireless.env" = {};
      "system-password" = {
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

  programs.ssh.knownHosts.github = {
    hostNames = ["github.com"];
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
  };
}
