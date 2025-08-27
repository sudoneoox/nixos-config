{
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
    #NOTE: sync subdir
    "d ${syncRoot}/sync 2775 rslsync rslsync -"
  ];

  ####INFO: Resilio configuration (declarative, no Web UI).
  services.resilio = {
    directoryRoot = syncRoot;
    downloadLimit = 0;
    uploadLimit = 0;
    enable = true;
    httpLogin = custom_vars.USERNAME;
    httpPass = "abcde";
    checkForUpdates = false;
    enableWebUI = true;
    httpListenAddr = "127.0.0.1";
    httpListenPort = 8888;
    deviceName = host;
    storagePath = "/var/lib/resilio-sync"; #INFO: keeps device identity per machine
  };

  ####INFO: Optional: make your login user able to write into the synced folder.
  users.users.${custom_vars.USERNAME}.extraGroups = ["rslsync"];
}
