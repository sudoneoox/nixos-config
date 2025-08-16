#WARN: Make sure to create a root-only deploy key to your private github repo holding your sops secrets
# sudo -i
# mkdir -p /root/.ssh && chmod 700 /root/.ssh/id_ed25519 -C "secrets-sync deploy key" -N ""
# chmod 600 /root/.ssh/id_ed25519 # (put the pub key as a github deploy key)
# ssh-keyscan github.com >> /root/.ssh/known_hosts # pre-trust githubs host-key
# chomd 644 /root/.ssh/known_hosts
# ssh -T git@github.com # Optionally you can test as root
#WARN: Sops needs the initial secrets before it can run so...
# sudo -i
# cd /var/lib/sops-nix/secrets/
# git clone GITHUB_SECRETS_REPO
{
  inputs,
  pkgs,
  ...
}: let
  GITHUB_SECRETS_REPO = "git@github.com:sudoneoox/nix-secrets.git";
  SOPS_PUBLIC_KEY = "age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2";
  SOPS_KEY_FILE = "/var/lib/sops-nix/key.txt";
  SOPS_SECRETS_PATH = "/var/lib/sops-nix/secrets";
  RESYNC_TIMER = 60;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  #INFO: Ensure the secrets dir exists with strict perms
  systemd.tmpfiles.rules = [
    "d /var/lib/sops-nix 0700 root root -"
    "d ${SOPS_SECRETS_PATH} 0700 root root -"
  ];

  #INFO: One-shot sync (run once at boot; also manually or via timer)
  systemd.services.secrets-sync = {
    description = "Sync encrypted secrets repo";
    wantedBy = ["multi-user.target"];
    before = ["sops-install-secrets.service"];
    after = ["network-online.target"];
    wants = ["network-online.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Group = "root";
    };
    path = [pkgs.git pkgs.coreutils];
    script = ''
      install -d -m 700 ${SOPS_SECRETS_PATH}
      if [ -d ${SOPS_SECRETS_PATH}/.git ]; then
        git -C ${SOPS_SECRETS_PATH} pull --ff-only
      else
        git clone --depth=1 ${GITHUB_SECRETS_REPO} ${SOPS_SECRETS_PATH}
      fi
      chmod -R go-rwx /var/lib/sops-nix
    '';
  };

  #INFO: Run every ${RESYNC_TIMER} minutes (and shortly after boot)
  systemd.timers.secrets-sync = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = "${toString RESYNC_TIMER}min";
      Unit = "secrets-sync.service";
    };
  };

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
