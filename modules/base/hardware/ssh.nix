{
  custom,
  lib,
  config,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.features.enableSSH {
    services.openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitEmptyPasswords = false;

        PermitRootLogin = "no";
        AllowUsers = ["${x.identity.username}" "root"];

        X11Forwarding = config.services.xserver.enable;

        AllowTcpForwarding = false;
        AllowAgentForwarding = false;
        PermitTunnel = false;

        UseDns = false;
        TCPKeepAlive = false;
        ClientAliveInterval = 300;
        ClientAliveCountMax = 0;

        MaxAuthTries = 3;
        MaxSessions = 2;

        LogLevel = "VERBOSE";

        KexAlgorithms = [
          "curve25519-sha256@libssh.org"
          "ecdh-sha2-nistp521"
          "ecdh-sha2-nistp384"
          "ecdh-sha2-nistp256"
          "diffie-hellman-group-exchange-sha256"
        ];
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes128-gcm@openssh.com"
          "aes256-ctr"
          "aes192-ctr"
          "aes128-ctr"
        ];
        Macs = [
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "umac-128-etm@openssh.com"
          "hmac-sha2-512"
          "hmac-sha2-256"
          "umac-128@openssh.com"
        ];
      };

      # Only needed if you’re managing host keys yourself.
      # (This is unrelated to 1Password; 1P is for *client* keys.)
      hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

    # Optional: open firewall only if you actually want inbound SSH
    # networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
