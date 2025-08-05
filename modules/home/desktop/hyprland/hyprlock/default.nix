{ username, ... }:

{
  home.file.".config/hypr/mocha.conf".source = ./mocha.conf;
  home.file.".config/hypr/hyprlock/background.png".source = ./background.png;
  home.file.".config/hypr/hyprlock/background.svg".source = ./background.svg;
  home.file.".config/hypr/hyprlock/face.jpg".source = ./face.jpg;

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = {
        monitor = "";
        path = "/home/${username}/.config/hypr/hyprlock/background.svg";
        blur_passes = 0;
        color = "1e1e2e";
      };

      label = [
        {
          monitor = "";
          text = "Layout: $LAYOUT";
          color = "cdd6f4";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = "30, -30";
          halign = "left";
          valign = "top";
        }

        {
          monitor = "";
          text = "$TIME";
          color = "cdd6f4";
          font_size = 90;
          font_family = "JetBrainsMono Nerd Font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }

        {
          monitor = "";
          text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
          color = "cdd6f4";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }

        {
          monitor = "";
          text = "$FPRINTPROMPT";
          color = "cdd6f4";
          font_size = 14;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -107";
          halign = "center";
          valign = "center";
        }
      ];

      image = {
        monitor = "";
        path = "/home/${username}/.config/hypr/hyprlock/face.jpg";
        size = 100;
        border_color = "[cba6f7]";
        position = "0, 75";
        halign = "center";
        valign = "center";
      };

      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "cba6f7";
        inner_color = "313244";
        font_color = "cdd6f4";
        fade_on_empty = false;
        placeholder_text = ''<span foreground="#cdd6f4"><i>󰌾 Logged in as </i><span foreground="#cba6f7">$USER</span></span>'';
        hide_input = false;
        check_color = "cba6f7";
        fail_color = "f38ba8";
        fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
        capslock_color = "f9e2af";
        position = "0, -47";
        halign = "center";
        valign = "center";
      };
    };
  };
}
