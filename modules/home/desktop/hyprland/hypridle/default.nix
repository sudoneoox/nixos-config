{ pkgs, ... }:
{

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "hyprlock";
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        # 2 min - Turn off keyboard backlight
        {
          timeout = 120;
          on-timeout = "brightnessctl -sd asus::kbd_backlight set 0";
          on-resume = "brightnessctl -rd asus::kbd_backlight";
        }

        # 3 min - Dim screen brightness
        {
          timeout = 180;
          on-timeout = "brightnessctl -s set 3";
          on-resume = "brightnessctl -r"; # restore
        }

        # 6 min - Lock the screen
        {
          timeout = 360;
          on-timeout = "pidof hyprlock || hyprlock";
        }

        # 30 min - Suspend
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
