{
  lib,
  X0,
  config,
  ...
}: {
  config = lib.mkIf X0.SYSTEM.SECURITY.kernel {
    security = {
      protectKernelImage = true;
      lockKernelModules = false; # breaks iptables, wireguard, and virtd

      # force-enable the Page Table Isolation (PTI) Linux kernel feature
      forcePageTableIsolation = true;

      # User namespaces are required for sandboxing.
      # this means you cannot set `"user.max_user_namespaces" = 0;` in sysctl
      allowUserNamespaces = true;

      # Disable unprivileged user namespaces, unless containers are enabled
      unprivilegedUsernsClone = config.virtualisation.containers.enable;
      allowSimultaneousMultithreading = true;
    };

    boot.kernel.sysctl = {
      # prevent pointer leaks
      "kernel.kptr_restrict" = 2;
      # prevent exploit of use-after-free flaws
      "vm.unprivileged_userfaultfd" = 0;

      # Network
      # protect against SYN flood attacks (denial of service attack)
      "net.ipv4.tcp_syncookies" = 1;
      # protection against TIME-WAIT assassination
      "net.ipv4.tcp_rfc1337" = 1;
      # enable source validation of packets received (prevents IP spoofing)
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;

      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      # Protect against IP spoofing
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      # prevent man-in-the-middle attacks
      "net.ipv4.icmp_echo_ignore_all" = 1;

      # ignore ICMP request, helps avoid Smurf attacks
      "net.ipv4.conf.all.forwarding" = 0;
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.default.accept_source_route" = 0;
      # Reverse path filtering causes the kernel to do source validation of
      "net.ipv6.conf.all.forwarding" = 0;
      "net.ipv6.conf.all.accept_ra" = 0;
      "net.ipv6.conf.default.accept_ra" = 0;

      ## TCP hardening
      # Prevent bogus ICMP errors from filling up logs.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # Disable TCP SACK
      "net.ipv4.tcp_sack" = 0;
      "net.ipv4.tcp_dsack" = 0;
      "net.ipv4.tcp_fack" = 0;

      # Userspace
      # restrict usage of ptrace
      "kernel.yama.ptrace_scope" = 2;

      # ASLR memory protection (64-bit systems)
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_rnd_compat_bits" = 16;

      # only permit symlinks to be followed when outside of a world-writable sticky directory
      "fs.protected_symlinks" = 1;
      "fs.protected_hardlinks" = 1;
      # Prevent creating files in potentially attacker-controlled environments
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;

      # Randomize memory
      "kernel.randomize_va_space" = 2;
      # Exec Shield (Stack protection)
      "kernel.exec-shield" = 1;

      ## TCP optimization
      # TCP Fast Open is a TCP extension that reduces network latency by packing
      # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
      # both incoming and outgoing connections:
      "net.ipv4.tcp_fastopen" = 3;
      # Bufferbloat mitigations + slight improvement in throughput & latency
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
    };
  };
}
