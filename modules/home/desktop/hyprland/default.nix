{ pkgs, ... }:
{

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.variables = [ "--all" ];

    plugins = with pkgs; [
      hyprland-plugins.hyprbars
      hyprspace
    ];

    settings =
      let
        terminal = "kitty";

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
          layout = "master";
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
          rounding = 5;
          active_opacity = 1.00;
          inactive_opacity = 0.95;
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

        #-- Layout : Master
        # See https://wiki.hyprland.org/Configuring/Master-Layout
        master = {
          allow_small_split = false;
          special_scale_factor = 0.80;
          mfact = 0.5;
          new_on_top = false;
          orientation = "left";
          inherit_fullscreen = true;
          smart_resizing = true;
          drop_at_cursor = true;
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
            # bar_color = "rgb(1e1e1e)";
            bar_color = "rgba(000000cc)"; # or match your window bg
            bar_precedence_over_border = true;
            col.text = "rgb(dedede)";
            bar_text_size = 10;
            bar_text_font = "JetBrainsMono Nerd Font Mono";
            bar_button_padding = 10;
            bar_padding = 6;
            # bar_precedence_over_border = false;
            hyprbars-button = [
              "rgb(ff5f56), 18, \uf00d, hyprctl dispatch killactive" # fa-times (close)
              "rgb(ffbd2e), 18, \uf068, hyprctl dispatch minimize" # fa-minus (minimize)
              "rgb(27c93f), 18, \uf2d0, hyprctl dispatch fullscreen" # fa-window-maximize
            ];
          };

          overview = {
            panelHeight = 80;
            panelColor = "rgba(1e1e1ecc)";
            workspaceActiveBackground = "rgba(ffffff15)";
            workspaceInactiveBackground = "rgba(00000008)";
            workspaceActiveBorder = "rgba(33aaffcc)";
            workspaceInactiveBorder = "rgba(ffffff22)";
            workspaceMargin = 10;
            workspaceBorderSize = 2;
            centerAligned = true;
            showEmptyWorkspace = true;
            showNewWorkspace = true;
            dragAlpha = 1.0;
            disableBlur = true;
            exitOnClick = true;
            exitKey = "Escape";
          };

        };

        bind = [
          # Application binds
          "SUPER, SPACE, exec, ${terminal}"
          "SUPER, Q, killactive"
          "SUPER, D, exec, ~/.config/hypr/assets/scripts/filemanager.sh"
          "SUPER, T, togglefloating"
          "SUPER, F, fullscreen"
          "SUPER, R, exec, rofi -show drun"
          "SUPER, P, pseudo"
          "SUPER, J, togglesplit"
          "SUPER SHIFT, B, exec, ~/.config/hypr/assets/scripts/reload-waybar.sh"
          "SUPER SHIFT, W, exec, ~/.config/hypr/assets/scripts/reload-hyprpaper.sh"

          # Hardware keys
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86WLAN, exec, nmcli radio wifi toggle"
          ", XF86Refresh, exec, xdotool key F5"

          # Focus movement
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

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
          "hyprpaper"
          "dunst"
          "copyq"
        ];

        env = [
          "LIBVA_DRIVER_NAME, nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "XCURSOR_SIZE,24"
        ];

        cursor = {
          no_hardware_cursors = true;
        };

      };

  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

}
