{custom, ...}: let
  x = custom.x0;
in {
  #INFO: conserve power on laptop when running on battery otherwise prefer performance | balanced_performance
  config =
    if x.derived.powerMgmtEff
    then {
      # stock NixOS powermanagement tool which allows for managing hibernate and suspend states
      # other power management tools may overwrite this setting
      powerManagement = {
        enable = true;
      };

      services.thermald.enable = true;

      services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNER_ON_AC = "performance";
          CPU_SCALING_GOVERNER_ON_BAT = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
          PLATFORM_PROFILE_ON_AC = "performance";
          PLATFORM_PROFILE_ON_BAT = "balance_power";
          CPU_BOOST_ON_AC = 1;
          CPU_HWP_DYN_BOOST_ON_AC = 1;
          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;
          START_CHARGE_THRESH_BAT0 = 75;
          STOP_CHARGE_THRESH_BAT0 = 80;
        };
      };
    }
    # Otherwise (on desktop) prefer performance
    else if x.derived.powerMgmtPerf
    then {
      services.tlp = {
        enable = true;
        settings = {
          #NOTE: We only configure the _ON_AC settings, since this is a desktop.

          # prioritize clock speed
          CPU_SCALING_GOVERNOR_ON_AC = "performance";

          # Set the energy/performance policy to 'performance'.
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          # Use the 'performance' platform profile.
          PLATFORM_PROFILE_ON_AC = "performance";

          # CPU boost is enabled.
          CPU_BOOST_ON_AC = 1;
          CPU_HWP_DYN_BOOST_ON_AC = 1;

          # Set maximum performance to 100% to keep clocks high.
          CPU_MIN_PERF_ON_AC = 10;
          CPU_MAX_PERF_ON_AC = 100;

          # Disable power saving for PCIe devices.
          PCIE_ASPM_ON_AC = "performance";

          # Disable USB autosuspend.
          USB_AUTOSUSPEND = 0;
        };
      };
    }
    #WARN: Else noting happened and ignore but assert
    else {
      assertions = [
        {
          assertion = x.derived.powerMgmtEff && x.derived.powerMgmtPerf;
          message = ''
            Note that x.derived.powerMgmtEff and x.derived.powerMgmtPerf were both set to false, either this was intentional and
            if so comment out the assert block in modules/base/hardware/powerManagement.nix. If this was not intentional look over schema.nix and values.nix to see
            where you went wrong.
          '';
        }
      ];
    };
}
