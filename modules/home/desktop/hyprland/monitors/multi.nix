{
  pkgs,
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf (x.derived.monitorsEff == "multi") {
    wayland.windowManager.hyprland = {
      # Specific Plugins to multi monitor setup
      plugins = with pkgs; [
        hyprland-smw
      ];

      settings = {
        monitor = [
          "DP-6,preferred,0x0,${x.system.scale}"

          "DP-4,preferred,1920x0,${x.system.scale}"
        ];

        plugin = {
          split-monitor-workspaces = {
            count = 4;
            keep_focused = false;
            enable_notifications = false;
            enable_persistent_workspaces = 1;
            enable_wrapping = false;
          };
        };

        windowrulev2 = [
          "float,class:^(flameshot)$"
          "move 0 0,class:^(flameshot)$"
          "pin,class:^(flameshot)$"
          "noanim,class:^(flameshot)$"
        ];

        bind = [
          # Volume Keybinds
          # Volume Up: Super + Ctrl + Up Arrow
          "SUPER CTRL, UP, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
          # Volume Down: Super + Ctrl + Down Arrow
          "SUPER CTRL, DOWN, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
          # Mute: Super + Ctrl + M
          "SUPER  CTRL, M, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # split-workspace switching
          "SUPER, 1, split-workspace, 1"
          "SUPER, 2, split-workspace, 2"
          "SUPER, 3, split-workspace, 3"
          "SUPER, 4, split-workspace, 4"

          # (CTRL + ALT + ARROWS)
          "CTRL ALT, right, split-workspace, e+1"
          "CTRL ALT, left, split-workspace, e-1"

          # Move windows to workspaces
          "SUPER SHIFT, 1, split-movetoworkspace, 1"
          "SUPER SHIFT, 2, split-movetoworkspace, 2"
          "SUPER SHIFT, 3, split-movetoworkspace, 3"
          "SUPER SHIFT, 4, split-movetoworkspace, 4"

          # Scroll through workspaces
          "SUPER, mouse_down, split-workspace, e+1"
          "SUPER, mouse_up, split-workspace, e-1"

          # MINIMIZE WINDOW
          "SUPER, N, exec, hyprctl dispatch tag active:minimized && hyprctl dispatch split-movetoworkspacesilent +10"

          "SUPER, M, exec, kitty --class fzfrestore --title 'Restore Hidden Window' --override background_opacity=0.92 -e /usr/bin/env bash ${pkgs.hyprRestoreWindow}/bin/hypr-restore-window"

          # toggle move workspace to other monitor
          "SUPER, O, exec, hyprctl dispatch split-changemonitor 1"
        ];
      };
    };
  };
}
