{
  config,
  host,
  custom_vars,
  ...
}: let
  #INFO: Where you want the synced data on each machine (same path everywhere).
  syncRoot = "/media/resilio/truenas";
in {
  ####INFO: Directory for your synced files; owned by rslsync so the service can write.
  systemd.tmpfiles.rules = [
    #INFO: mode 2775 = g+w and setgid so new files inherit group "rslsync"
    "d ${syncRoot} 2775 rslsync rslsync -"
  ];

  ####INFO: Resilio configuration (declarative, no Web UI).
  services.resilio = {
    enable = true;
    enableWebUI = false; #INFO: required when using sharedFolders (asserted by module)
    deviceName = "nixos-${host}";
    storagePath = "/var/lib/resilio-sync"; #INFO: keeps device identity per machine
    #INFO: Tip: leave listeningPort = 0 (random) unless you plan to port-forward through a router.

    sharedFolders = [
      {
        directory = syncRoot;
        secretFile = config.sops.secrets."resilio-truenas-key".path;
        useRelayServer = true;
        useTracker = true;
        useDHT = true;
        searchLAN = true;
        useSyncTrash = true;
        knownHosts = []; #INFO: e.g. "truenas.lan:55555" if you want direct host:port
      }
    ];
  };

  ####INFO: Optional: make your login user able to write into the synced folder.
  users.users.${custom_vars.USERNAME}.extraGroups = ["rslsync"];

  #INFO: LAN discovery uses UDP 3838; open it if your firewall is strict.
  networking.firewall.allowedUDPPorts = [3838];
}
