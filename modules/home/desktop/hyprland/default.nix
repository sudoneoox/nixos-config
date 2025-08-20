{
  lib,
  custom_vars,
  pkgs,
  ...
}: {
  # Assets that plugins or scripts use
  services = {
    gnome-keyring = {
      enable = true;
      components = ["secrets"];
    };
    network-manager-applet.enable = true;
  };

  wayland.windowManager.hyprland = {
    plugins = [
      pkgs.hyprland-plugins.hyprbars
      pkgs.hyprspace
      pkgs.hy3
    ];

    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.variables = ["--all"];

    extraConfig = ''
      source = ~/.config/hypr/colors.conf
    '';

    settings = let
      terminal = custom_vars.TERMINAL;
      filemanager = custom_vars.FILE_MANAGER;
      shadow_color = "rgba(1a1a1aee)";
    in {
      input = {
        follow_mouse = 1;
        kb_layout = "us";
      };

      general = {
        #WARN: Border colors are generated with wallust
        border_size = 2;
        no_border_on_floating = false;
        gaps_in = 2;
        gaps_out = 6;
        float_gaps = 0;
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
          new_optimizations = true;
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

        "float, class:fzfrestore"
        "size 1700 900, class:fzfrestore"
        "center, class:fzfrestore"
        "stayfocused, class:fzfrestore"

        "float, class:fzfwallpicker"
        "size 1700 900, class:fzfwallpicker"
        "center, class:fzfwallpicker"
        "stayfocused, class:fzfwallpicker"

        "dimaround, class:^(rofi)$" # dim background around rofi
        "noanim, class:^(rofi)$" # snappier open/close
        "opacity 0.96 0.92, class:^(rofi)$" # active/inactive opacity
      ];

      plugin = {
        hyprbars = {
          bar_height = 30;
          bar_color = "rgba(000000cc)";
          bar_precedence_over_border = true;
          col.text = "rgb(dedede)";
          bar_text_size = 10;
          bar_text_font = "JetBrainsMono Nerd Font Mono";
          bar_button_padding = 10;
          bar_padding = 6;
          hyprbars-button = [
            "rgb(ff5f56), 18, 󰅙, hyprctl dispatch killactive"
            "rgb(ffbd2e), 18, , hyprctl dispatch tag active:minimized && hyprctl dispatch movetoworkspacesilent +10"
            "rgb(27c93f), 18, , hyprctl dispatch fullscreen"
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
        #INFO: Hyprland Reload
        "SUPER SHIFT, R, exec,  hyprctl reload"
        #INFO: Application binds
        "SUPER, SPACE, exec, ${terminal}"
        "SUPER, D, exec, ${filemanager}"
        "SUPER, T, togglefloating"
        "SUPER, F, fullscreen"
        "SUPER, R, exec, rofi -show drun"
        "SUPER, J, togglesplit"

        #INFO: HYPRSPACE
        "SUPER, 0, overview:toggle"

        #INFO: HY3
        #INFO: Split into groups
        "SUPER, H, hy3:makegroup, h"
        "SUPER, V, hy3:makegroup, v"
        "SUPER CTRL, T, hy3:makegroup, tab"

        #INFO: Move between windows
        "SUPER, left, hy3:movefocus, left"
        "SUPER, right, hy3:movefocus, right"
        "SUPER, up, hy3:movefocus, up"
        "SUPER, down, hy3:movefocus, down"

        #INFO: Move windows
        "SUPER SHIFT, left, hy3:movewindow, left"
        "SUPER SHIFT, right, hy3:movewindow, right"
        "SUPER SHIFT, up, hy3:movewindow, up"
        "SUPER SHIFT, down, hy3:movewindow, down"

        #INFO: Kill focused node
        "SUPER, Q, hy3:killactive"

        #INFO: Tab switching
        "SUPER, TAB, hy3:focustab, right"
        "SUPER SHIFT, TAB, hy3:focustab, left"

        #INFO: Focus top/bottom container
        "SUPER, A, hy3:changefocus, raise"
        "SUPER, Z, hy3:changefocus, lower"

        #INFO: Toggle tiled/floating layer focus
        "SUPER, grave, hy3:togglefocuslayer"

        #INFO: Make groups ephemeral
        "SUPER, E, hy3:setephemeral, true"

        #INFO: WAYBAR
        "SUPER, B, exec, pkill -SIGUSR1 waybar || waybar"

        #INFO: HYPRLOCk
        "SUPER, L, exec, hyprlock"

        #INFO: SCREENSHOT
        "SUPER, S, exec, flameshot gui"

        #INFO: COLOR PICKER
        "SUPER SHIFT, C, exec, hyprpicker -a -f hex -l"

        #INFO: CLIPBOARD
        "SUPER, V, exec, copyq --start-server show"

        #INFO: Wallust Wallpaper Changes
        "SUPER, W, exec, kitty --class fzfwallpicker --title 'Pick Wallpaper' --override background_opacity=0.92 -e /usr/bin/env bash ${pkgs.wallustPick}/bin/wallust-pick"
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
        "sleep 1 && hyprctl dispatch layoutmsg hy3"
        "waybar"
        "hyprctl setcursor macOS 26"
        "hypridle"
      ];

      exec = [
        "hyprshade on /home/${custom_vars.USERNAME}/.config/hypr/shaders/vibrance"
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

  imports =
    [
      ./waybar
      ./hyprlock
      ./hyprpaper
      ./hyprshade
    ]
    ++ lib.optional (custom_vars.MONITORS == "single") ./monitors/single.nix
    ++ lib.optional (custom_vars.MONITORS == "multi") ./monitors/multi.nix;
}
