{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "";
          blur_passes = 1;
          blur_size = 7;
          noise = 0.0117;
        }
      ];

      labels = [
        {
          monitor = "";
          text = "Layout: $LAYOUT";
          color = "#cdd6f4"; # text
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = {
            x = 30;
            y = -30;
          };
          halign = "left";
          valign = "top";
        }
        {
          monitor = "";
          text = "$TIME";
          color = "#cdd6f4"; # text
          font_size = 90;
          font_family = "JetBrainsMono Nerd Font";
          position = {
            x = -30;
            y = 0;
          };
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
          color = "#cdd6f4"; # text
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = {
            x = -30;
            y = -150;
          };
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "$FPRINTPROMPT";
          color = "#cdd6f4"; # text
          font_size = 14;
          font_family = "JetBrainsMono Nerd Font";
          position = {
            x = 0;
            y = -107;
          };
          halign = "center";
          valign = "center";
        }
      ];

      images = [
        {
          monitor = "";
          size = 100;
          border_color = "#cba6f7"; # mauve
          position = {
            x = 0;
            y = 75;
          };
          halign = "center";
          valign = "center";
        }
      ];

      input-fields = [
        {
          monitor = "";
          size = {
            width = 300;
            height = 60;
          };
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;

          outer_color = "#cba6f7"; # mauve
          inner_color = "#313244"; # surface0
          font_color = "#cdd6f4"; # text

          fade_on_empty = false;

          placeholder_text = ''<span foreground="#cdd6f4"><i>󰌾 Logged in as </i><span foreground="#cba6f7">$USER</span></span>'';

          hide_input = false;

          check_color = "#a6e3a1"; # green
          fail_color = "#f38ba8"; # red
          fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
          capslock_color = "#f9e2af"; # yellow

          position = {
            x = 0;
            y = -47;
          };
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
