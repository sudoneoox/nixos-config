#WARN: Make sure to create a root-only deploy key to your private github repo holding your sops secrets
# sudo -i
# install -d -m 700 /root/.ssh
# ssh-keygen -t ed25519 -C "secrets-sync deploy key" -f /root/.ssh/id_ed25519 -N ""  # (put the pub key as a github deploy key)
# ssh-keyscan github.com >> /root/.ssh/known_hosts # pre-trust githubs host-key
# chomd 644 /root/.ssh/known_hosts
# ssh -T git@github.com # Optionally you can test as root
#WARN: Sops needs the initial secrets before it can run so...
# sudo -i
# cd /var/lib/sops-nix/secrets/
# git clone GITHUB_SECRETS_REPO
{pkgs, ...}: let
  GITHUB_SECRETS_REPO = "git@github.com:sudoneoox/nix-secrets.git";
  SOPS_SECRETS_PATH = "/var/lib/sops-nix/secrets";
  RESYNC_TIMER = 60;
in {
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
      Environment = [
        "$HOME=/root"
        "GIT_SSH_COMMAND=${pkgs.openssh}/bin/ssh -oBatchMode=yes -oStrictHostKeyChecking=yes"
      ];
    };
    path = [pkgs.git pkgs.coreutils pkgs.openssh];
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
}
