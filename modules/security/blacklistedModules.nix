{
  lib,
  custom_vars,
  ...
}: {
  config = lib.mkIf custom_vars.SYSTEM.SECURITY.blacklistedModules {
    boot.blacklistedKernelModules = [
      # Obscure networking protocols
      "dccp" # Datagram Congestion Control Protocol
      "sctp" # Stream Control Transmission Protocol
      "rds" # Reliable Datagram Sockets
      "tipc" # Transparent Inter-Process Communication
      "n-hdlc" # High-level Data Link Control
      "ax25" # Amateur X.25
      "netrom" # NetRom
      "x25" # X.25
      "rose"
      "decnet"
      "econet"
      "af_802154" # IEEE 802.15.4
      "ipx" # Internetwork Packet Exchange
      "appletalk"
      "psnap" # SubnetworkAccess Protocol
      "p8023" # Novell raw IEE 802.3
      "p8022" # IEE 802.3
      "can" # Controller Area Network
      "atm"

      # Various rare filesystems
      "cramfs"
      "freevxfs"
      "jffs2"
      "hfs"
      "hfsplus"
      "udf"

      # "squashfs"  # compressed read-only file system used for Live CDs
      # "cifs"  # cmb (Common Internet File System)
      # "nfs"  # Network File System
      # "nfsv3"
      # "nfsv4"
      # "ksmbd"  # SMB3 Kernel Server
      # "gfs2"  # Global File System 2
      # vivid driver is only useful for testing purposes and has been the
      # cause of privilege escalation vulnerabilities
      # "vivid"
    ];
  };
}
