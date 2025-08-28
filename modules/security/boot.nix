{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.x0.system.security.boot {
    # https://madaidans-insecurities.github.io/guides/linux-hardening.html#boot-parameters
    boot.kernelParams = [
      # enables zeroing of memory during allocation and free time
      # helps mitigate use-after-free vulnerabilaties
      "init_on_alloc=1"
      "init_on_free=1"
      # disables vsyscalls, they've been replaced with vDSO
      "vsyscall=none"
      # certain exploits cause an "oops", this makes the kernel panic if an "oops" occurs
      "oops=panic"
      # prevents user space code excalation
      "lockdown=confidentiality"
    ];
  };
}
