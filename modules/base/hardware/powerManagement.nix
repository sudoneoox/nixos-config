{custom, ...}: let
  x = custom.x0;
in {
  #INFO: conserve power on laptop when running on battery otherwise prefer performance | balanced_performance
  config =
    if x.derived.powerMgmtEff
    then {
      # stock NixOS powermanagement tool which allows for managing hibernate and suspend states
      # other power management tools may overwrite this setting

      powerManagement.enable = true;

      services.thermald.enable = true;

      services.tlp = {
        enable = true;
        settings = {
          # Governors
          CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          # HWP / Energy-Perf Policy (EPP)
          # "balance_performance" keeps snappiness without crazy bursts
          CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

          # Platform profile (firmware-side behavior)
          PLATFORM_PROFILE_ON_AC = "balanced";
          PLATFORM_PROFILE_ON_BAT = "power-saver";

          # Turbo
          # causes fans to ramp up on intel so I disabled it
          CPU_BOOST_ON_AC = 0;
          CPU_HWP_DYN_BOOST_ON_AC = 1;

          # Caps
          CPU_MIN_PERF_ON_AC = 10;
          CPU_MAX_PERF_ON_AC = 100;

          # Battery policy
          CPU_BOOST_ON_BAT = 0;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 30;
          START_CHARGE_THRESH_BAT0 = 75;
          STOP_CHARGE_THRESH_BAT0 = 80;
        };
      };

      # Suspend on lid close
      services.logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
      };

      # ┏━ 2 Traces:
    }
    # Otherwise (on desktop) prefer performance
    else if x.derived.powerMgmtPerf
    then {
      services.tlp = {
        enable = true;
        settings = {
          #NOTE: We only configure the _ON_AC settings, since this is a desktop.

          # prioritize clock speed
          CPU_SCALING_GOVERNOR_ON_AC = "schedutil";

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
