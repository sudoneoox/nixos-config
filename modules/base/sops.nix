{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = ../../hosts/common/secrets.enc.yaml;
    secrets = {
      "wireless.env" = {};
      "system-password" = {
        neededForUsers = true;
      };
    };

    age = {
      # place generated key file here for secrets
      # sudo install -m 0400 -o root -g root key.txt /var/lib/sops-nix/key.txt
      keyFile = "/var/lib/sops-nix/key.txt";
      # We generate it ourself
      generateKey = false;
    };
  };

  environment.systemPackages = with pkgs; [sops];
  environment.variables = {
    SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/key.txt";
    SOPS_AGE_RECIPIENTS = "age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2";
  };
}
