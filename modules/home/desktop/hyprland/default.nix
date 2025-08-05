{ pkgs, ... }:
{

  imports = [
    ./cursor
    ./waybar
    ./hyprlock
    ./hyprpaper
    ./hypridle
    ./hyprshade
    ./dunst
    ../rofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.variables = [ "--all" ];

    plugins = [
      pkgs.hyprland-plugins.hyprbars
      pkgs.hyprspace
      pkgs.hy3
    ];

    settings =
      let
        terminal = "kitty";
        filemanager = "thunar";
        active_border = "rgba(0,190,150,1) rgba(0,0,0,0) rgba(100,190,255,1) rgba(0,0,0,0) rgba(0,190,150,1) 35deg";
        inactive_border = "rgba(515251ff)";
        shadow_color = "rgba(1a1a1aee)";

      in
      {

        monitor = ",preferred,auto,1";

        input = {
          follow_mouse = 1;
          kb_layout = "us";
          touchpad = {
            disable_while_typing = true;
            natural_scroll = false;
            tap-to-click = false;
          };
        };

        general = {
          border_size = 2;
          no_border_on_floating = false;
          gaps_in = 2;
          gaps_out = 6;
          float_gaps = 0;
          "col.active_border" = active_border;
          "col.inactive_border" = inactive_border;
          layout = "hy3";
          resize_on_border = false;
          snap = {
            enabled = true;
            window_gap = 10;
          };
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        decoration = {
          rounding = 8;
          active_opacity = 1.00;
          inactive_opacity = 0.97;
          fullscreen_opacity = 1.00;
          dim_inactive = true;
          dim_strength = 0.15;
          blur = {
            enabled = true;
            size = 4;
            passes = 1;
            brightness = 0.80;
            xray = true;
            special = true;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = shadow_color;
          };
        };

        animations = {
          enabled = true;
          bezier = [
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92"
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.38, 0.04, 1, 0.07"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "softAcDecel, 0.26, 0.26, 0.15, 1"
            "md2, 0.4, 0, 0.2, 1"
          ];
          animation = [
            "windows, 1, 3, md3_decel, popin 60%"
            "windowsIn, 1, 3, md3_decel, popin 60%"
            "windowsOut, 1, 3, md3_accel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 3, md3_decel"
            "layersIn, 1, 3, menu_decel, slide"
            "layersOut, 1, 1.6, menu_accel"
            "fadeLayersIn, 1, 2, menu_decel"
            "fadeLayersOut, 1, 4.5, menu_accel"
            "workspaces, 1, 7, menu_decel, slide"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];
        };

        windowrulev2 = [
          "float, class:com.github.hluk.copyq"
          "size 800 600, class:com.github.hluk.copyq"
          "float, class:org.pulseaudio.pavucontrol"
          "size 800, 600, class:com.pulseaudio.pavucontrol"
        ];

        plugin = {
          hyprbars = {
            bar_height = 30;
            bar_color = "rgba(000000cc)"; # or match your window bg
            bar_precedence_over_border = true;
            col.text = "rgb(dedede)";
            bar_text_size = 10;
            bar_text_font = "JetBrainsMono Nerd Font Mono";
            bar_button_padding = 10;
            bar_padding = 6;
            hyprbars-button = [
              "rgb(ff5f56), 18, 󰅙, hyprctl dispatch killactive" # fa-times (close)
              # "rgb(ffbd2e), 18, , hyprctl dispatch movetoworkspace special:minimized" # fa-minus (minimize)
              "rgb(27c93f), 18, , hyprctl dispatch fullscreen" # fa-window-maximize
            ];
          };

          overview = {
            panelHeight = 100;
            panelColor = "rgba(101010aa)";
            panelBorderColor = "rgba(ffffff33)";
            panelBorderWidth = 1;

            workspaceActiveBackground = "rgba(ffffff18)";
            workspaceInactiveBackground = "rgba(ffffff05)";
            workspaceActiveBorder = "rgba(33aaffcc)";
            workspaceInactiveBorder = "rgba(aaaaaa22)";
            workspaceMargin = 14;
            workspaceBorderSize = 3;

            dragAlpha = 0.9;
            centerAligned = true;
            reservedArea = 0;

            hideBackgroundLayers = true; # setting this to false bugs it out
            hideOverlayLayers = true;
            hideTopLayers = true;
            hideRealLayers = false;
            drawActiveWorkspace = true;
            disableBlur = false;
            overrideAnimSpeed = 0.8;

            overrideGaps = true;
            gapsIn = 6;
            gapsOut = 12;
            affectStrut = false;

            autoDrag = true;
            autoScroll = true;
            exitOnClick = true;
            switchOnDrop = true;
            exitOnSwitch = true;
            showNewWorkspace = false;
            showEmptyWorkspace = false;
            showSpecialWorkspace = true;
            disableGestures = false;
            reverseSwipe = false;
            exitKey = "Escape";
          };

          hy3 = {
            no_gaps_when_only = 1;
            node_collapse_policy = 2;
            group_inset = 6;
            tab_first_window = false;
            autotile = {
              enable = true;
              ephemeral_groups = true;
              trigger_width = 800;
              trigger_height = 0;
              workspaces = "all";
            };
            tabs = {
              height = 22;
              padding = 6;
              from_top = false;
              radius = 6;
              border_width = 2;
              render_text = true;
              text_center = true;
              text_font = "JetBrainsMono Nerd Font";
              text_height = 8;
              text_padding = 3;
              "col.active" = "rgba(33ccff40)";
              "col.active.border" = "rgba(33ccffee)";
              "col.active.text" = "rgba(ffffffff)";
              "col.focused" = "rgba(60606040)";
              "col.focused.border" = "rgba(808080ee)";
              "col.focused.text" = "rgba(ffffffff)";
              "col.inactive" = "rgba(30303020)";
              "col.inactive.border" = "rgba(606060aa)";
              "col.inactive.text" = "rgba(ffffffff)";
              blur = true;
              opacity = 0.9;
            };
          };

        };

        bind = [
          # Application binds
          "SUPER, SPACE, exec, ${terminal}"
          "SUPER, D, exec, ${filemanager}"
          "SUPER, T, togglefloating"
          "SUPER, F, fullscreen"
          "SUPER, R, exec, rofi -show drun"
          "SUPER, J, togglesplit"

          # Hardware keys
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # Workspace switching
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          # (CTRL + ALT + ARROWS)
          "CTRL ALT, right, workspace, e+1"
          "CTRL ALT, left, workspace, e-1"

          # Move windows to workspaces
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          # Scroll through workspaces
          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"

          # HYPRSPACE
          "SUPER, 0, overview:toggle"

          # HY3
          # Split into groups
          "SUPER, H, hy3:makegroup, h"
          "SUPER, V, hy3:makegroup, v"
          "SUPER CTRL, T, hy3:makegroup, tab"

          # Move between windows
          "SUPER, left, hy3:movefocus, left"
          "SUPER, right, hy3:movefocus, right"
          "SUPER, up, hy3:movefocus, up"
          "SUPER, down, hy3:movefocus, down"

          # Move windows
          "SUPER SHIFT, left, hy3:movewindow, left"
          "SUPER SHIFT, right, hy3:movewindow, right"
          "SUPER SHIFT, up, hy3:movewindow, up"
          "SUPER SHIFT, down, hy3:movewindow, down"

          # Kill focused node
          "SUPER, Q, hy3:killactive"

          # Tab switching
          "SUPER, TAB, hy3:focustab, right"
          "SUPER SHIFT, TAB, hy3:focustab, left"

          # Focus top/bottom container
          "SUPER, A, hy3:changefocus, raise"
          "SUPER, Z, hy3:changefocus, lower"

          # Toggle tiled/floating layer focus
          "SUPER, grave, hy3:togglefocuslayer"

          # Make groups ephemeral
          "SUPER, E, hy3:setephemeral, true"

          # WAYBAR
          "SUPER, B, exec, pkill -SIGUSR1 waybar || waybar"

          # HYPRLOCk
          "SUPER, L, exec, hyprlock"

          # HYPRPAPER
          "SUPER SHIFT, W, exec, pkill hyprpaper && sleep 1 && hyprpaper &"

          # SCREENSHOT
          "SUPER, S, exec, flameshot gui"

          # COLOR PICKER
          "SUPER SHIFT, C, exec, hyprpicker -a -f hex -l"

          # CLIPBOARD
          "SUPER, V, exec, copyq --start-server show"

        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        debug = {
          overlay = false;
          damage_blink = false;
        };

        misc = {
          disable_splash_rendering = true;
        };

        "exec-once" = [
          "dunst"
          "copyq --start-server"
          "hyprlock || hyprctl dispatch exit"
          "sleep 1 && hyprctl dispatch layoutmsg hy3"
          "waybar"
          "hyprctl setcursor macOS 26"
          "hypridle"
        ];

        exec = [
          "hyprshade on vibrance"
        ];

        env = [
          "LIBVA_DRIVER_NAME, nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];

        cursor = {
          no_hardware_cursors = true;
        };

      };

  };

}
