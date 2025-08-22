{
  pkgs,
  custom_vars,
  ...
}: {
  # Imports specific to single-monitor setups (usually laptops)
  imports = [
    ../hypridle
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = let
        scale = toString custom_vars.SCALE;
        base = ",preferred,auto,${scale}";
        hdr =
          if (custom_vars.FEATURES.ENABLE_HDR or false)
          then ",bitdepth,10,cm,hdr"
          else "";
      in [
        "${base}${hdr}"
      ];

      input = {
        touchpad = {
          disable_while_typing = true;
          natural_scroll = false;
          tap-to-click = false;
        };
      };
      bind = [
        # Hardware keys
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 2%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 2%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # Workspace switching
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"

        # (CTRL + ALT + ARROWS)
        "CTRL ALT, right, workspace, e+1"
        "CTRL ALT, left, workspace, e-1"

        # Move windows to workspaces
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"

        # Scroll through workspaces
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # MINIMIZE WINDOW
        "SUPER, N, exec, hyprctl dispatch tag active:minimized && hyprctl dispatch movetoworkspacesilent +10"
        "SUPER, M, exec, kitty --class fzfrestore --title 'Restore Hidden Window' --override background_opacity=0.92 -e /usr/bin/env bash ${pkgs.hyprRestoreWindow}/bin/hypr-restore-window"
      ];
    };
  };
}
