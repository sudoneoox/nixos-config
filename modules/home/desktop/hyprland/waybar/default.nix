{
  pkgs,
  lib,
  host,
  ...
}: let
  isLaptop = host == "X0NixOSLaptop";

  # WARN: obviously not a good conditional but i'm not passing anything to distinct
  # different CPU manufacturers. I only have two systems so this isn't an issue for me
  isIntelCPU = host == "X0NixOSLaptop";
in {
  home.packages = with pkgs; [
    lm_sensors
    bluez
    procps
    upower
    brightnessctl
  ];

  imports = [
    ./waybar-style.nix
  ];

  programs.waybar = {
    enable = true;
    settings = [
      {
        name = "bar";
        mode = "dock";
        layer = "top";
        position = "top";
        height = 17;
        spacing = 0;
        modules-left = [
          "hyprland/workspaces"
          "custom/lock"
          "custom/reboot"
          "custom/power"
        ];
        modules-center = ["hyprland/window"];
        modules-right = [
          # "custom/nix-updates"
          "disk"
          "bluetooth"
          "custom/temperature"
          "memory"
          "cpu"
        ];

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
          format = "{icon}";
          on-click = "activate";
          persistent-workspaces."*" = lib.mkIf isLaptop [1 2 3 4];
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "active" = "󱙧";
          };
        };

        # "custom/nix-updates" = {
        #   # Defined in pkgs/scripts
        #   "exec" = "nix-update-checker";
        #   "signal" = 12;
        #   "on-click" = "pkill -x -RTMIN+12 .waybar-wrapped"; # refresh on click
        #   "on-click-right" = "rm ~/.cache/nix-update-last-run"; # force an update
        #   "interval" = 3600; # refresh every hour
        #   "tooltip" = true;
        #   "return-type" = "json";
        #   "format" = "{} {icon}";
        #   "format-icons" = {
        #     "has-updates" = "󰚰"; # icon when updates needed
        #     "updating" = ""; # icon when updating
        #     "updated" = ""; # icon when all packages updated
        #     "error" = ""; # icon when errot occurs
        #   };
        # };

        "custom/lock" = {
          format = "  ";
          on-click = "hyprlock";
          tooltip = true;
          tooltip-format = "Lock screen";
        };

        "custom/reboot" = {
          format = "  ";
          on-click = "systemctl reboot";
          tooltip = true;
          tooltip-format = "Reboot";
        };

        "custom/power" = {
          format = "  ";
          on-click = "systemctl poweroff";
          tooltip = true;
          tooltip-format = "Shutdown";
        };

        "custom/temperature" = {
          exec =
            if isIntelCPU
            then "sensors | awk '/^Package id 0:/ {print int($4)}'"
            else "sensors | awk '/^Tctl:/ {print int($2)}' || sensors | awk '/^Tdie:/ {print int($2)}'";

          format = "  {}°C ";
          interval = 5;
          tooltip = true;
          tooltip-format = "CPU temperature: {}°C";
        };

        memory = {
          format = "   {used:0.1f}G/{total:0.1f}G ";
          tooltip = true;
          tooltip-format = "Memory usage: {used:0.2f}G/{total:0.2f}G";
        };

        cpu = {
          format = "  {usage}%";
          tooltip = true;
        };

        disk = {
          interval = 60;
          format = "  {specific_used:0.2} GB";
          path = "/";
          tooltip = true;
          tooltip-format = "{specific_free:0.2f} GB out of {specific_total:0.2f} GB";
          unit = "GB";
        };

        bluetooth = {
          format = "  {status} ";
          format-connected = "  {device_alias} ";
          format-connected-battery = "  {device_alias}{device_battery_percentage}% ";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "kitty -e bluetoothctl";
        };
      }
      {
        name = "dock";
        layer = "top";
        position = "bottom";
        height = 17;
        modules-center = ["wlr/taskbar"];
        modules-right = ["network" "pulseaudio" "backlight" "tray"];
        modules-left = ["clock" "battery"];

        "wlr/taskbar" = {
          format = "{icon} {name}";
          tooltip-format = "{title}";
          on-click = "activate";
          icon-size = 19;
          all-outputs = false;
          ignore-list = [];
          show-special = true;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = " {icon} {capacity}% ";
          format-charging = " 󱐋{capacity}%";
          interval = 1;
          format-icons = [
            "󰂎"
            "󰁼"
            "󰁿"
            "󰂁"
            "󰁹"
          ];
          tooltip = true;
        };

        network = {
          format-wifi = "󰤨  {essid}";
          format-ethernet = "  Wired";
          tooltip-format = "<span color='#FF1493'> 󰅧 </span>{bandwidthUpBytes}  <span color='#00BFFF'> 󰅢 </span>{bandwidthDownBytes}";
          format-linked = " 󱘖 {ifname} (No IP) ";
          format-disconnected = "  Disconnected ";
          format-alt = " 󰤨 {signalStrength}% ";
          interval = 1;
        };

        pulseaudio = {
          format = "{icon}{volume}% ";
          format-muted = " 󰖁 0% ";
          format-icons = {
            headphone = "  ";
            hands-free = "  ";
            headset = "  ";
            phone = "  ";
            portable = "  ";
            car = "  ";
            default = [
              "  "
              "  "
              "  "
            ];
          };
          on-click-right = "pavucontrol -t 3";
          on-click = "pactl -- set-sink-mute 0 toggle";
          tooltip = true;
          tooltip-format = "Current volume: {volume}%";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon}{percent}% ";
          tooltip = true;
          tooltip-format = "Current brightness: {percent}%";
          format-icons = [
            " 󰃞 "
            " 󰃝 "
            " 󰃟 "
            " 󰃠 "
          ];
        };

        clock = {
          interval = 1;
          timezone = "US/Central";
          format = "  {:%I:%M %p}";
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-oos = "right";
            on-scroll = 1;
            format = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
            on-click-right = "shift_reset";
          };
        };

        tray = {
          icon-size = 17;
          spacing = 6;
        };
      }
    ];
  };
}
