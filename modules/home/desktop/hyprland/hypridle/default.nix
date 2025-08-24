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

        # 5 min - Dim screen brightness
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 1";
          on-resume = "brightnessctl -r"; # restore
        }

        # 6 min - Lock the screen
        {
          timeout = 360;
          on-timeout = "pidof hyprlock || hyprlock";
        }

        # 45 min - poweroff
        {
          timeout = 2700;
          on-timeout = "poweroff";
        }
      ];
    };
  };
}
