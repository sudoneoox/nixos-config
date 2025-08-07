{ username, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 1;
        font = "JetBrainsMono Nerd Font 10";
        frame_width = 2;
        frame_color = "#b4befe";
        separator_color = "frame";
        highlight = "#89b4fa";
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        corner_radius = 8;
        progress_bar = true;
        progress_bar_height = 4;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 8;
        progress_bar_corners = "top-left,bottom-right";
        corners = "top-left,bottom";
        offset = "15x25";
        gap_size = 8;
        padding = 12;
        horizontal_padding = 16;
        word_wrap = true;
        ignore_newline = false;
        transparency = 10;
        alignment = "center";
        show_indicators = true;
        separator_height = 2;
        format = "<b>󰁕 %a</b>\n%s\n<i>%b</i>";
        markup = "full";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 48;
      };

      urgency_low = {
        foreground = "#a6e3a1";
        frame_color = "#a6e3a1";
        progress_bar_color = "#a6e3a1";
        default_icon = "/home/${username}/Assets/nixos-config/Icons/dunst/bell-badge-low.svg";
        timeout = 2;
      };

      urgency_normal = {
        foreground = "#74c7ec";
        frame_color = "#74c7ec";
        progress_bar_color = "#74c7ec";
        default_icon = "/home/${username}/Assets/nixos-config/Icons/dunst/bell-badge.svg";
        timeout = 4;
      };

      urgency_critical = {
        foreground = "#f38ba8";
        frame_color = "#f38ba8";
        progress_bar_color = "#f38ba8";
        default_icon = "/home/${username}/Assets/nixos-config/Icons/dunst/alert-decagram.svg";
        timeout = 6;
      };
    };
  };
}
