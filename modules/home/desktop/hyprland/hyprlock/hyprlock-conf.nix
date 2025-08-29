{
  custom,
  pkgs,
  ...
}: let
  x = custom.x0;
  wp_path = "${x.cachePath}/current_wallpaper";
  font = x.ux.font;
  profile_photo = "${x.nixosAssetsPath}/Icons/hyprlock/face.jpg";
  greeting_text = "Welcome!";
  hyprlock_conf_path = "$HOME/.config/hyprlock";
in {
  xdg.configFile."hypr/hyprlock.conf" = {
    text = ''
      $hyprlockDir = ${hyprlock_conf_path}

      # Script Path
      # defined in pkgs/scripts
      $music = ${pkgs.playerctlLock}/bin/playerctl-lock

      $mpris_art = /tmp/hyde-mpris.png
      $wall = ${wp_path}

      #INFO: BACKGROUND
      background {
          monitor =
          path = $wall
          #blur_passes = 0
          #contrast = 0.8916
          #brightness = 0.8172
          #vibrancy = 0.1696
          #vibrancy_darkness = 0.0
      }

      #INFO: GENERAL
      general {
          no_fade_in = false
          disable_loading_bar = false
          grace = 1
      }

      #INFO: GREETINGS
      label {
          monitor =
          text = ${greeting_text}
          color = rgb(205, 214, 244)
          font_size = 55
          font_family = ${font}
          position = -630, 320
          halign = center
          valign = center
      }

      #INFO: Time
      label {
          monitor =
          text = cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"
          color = rgb(205, 214, 244)
          font_size = 40
          font_family = ${font}
          position = -630, 240
          halign = center
          valign = center
      }

      #INFO: Day-Month-Date
      label {
          monitor =
          text = cmd[update:1000000] echo "<span>$(date "+%A, %B %-d")</span>"
          color = rgba(205, 214, 224, .75)
          font_size = 20
          text_align = left
          font_family = ${font}
          position = 180, 175
          halign = left
          valign = center
      }

      #INFO: Profie-Photo
      image {
          monitor =
          path = ${profile_photo}
          border_size = 1
          border_color = rgba(137, 180, 250, .75)
          size = 160
          rounding = -1
          rotate = 0
          reload_time = -1
          reload_cmd =
          position = -630, 25
          halign = center
          valign = center
      }

      #INFO: USER-BOX
      shape {
          monitor =
          size = 320, 55
          color = rgba(88, 91, 112, 0.4)
          rounding = -1
          border_size = 0
          border_color = rgb(255, 255, 255)
          rotate = 0
          xray = false #INFO: if true, make a "hole" in the background (rectangle of specified size, no rotation)

          position = -630, -140
          halign = center
          valign = center
      }

      #INFO: USER
      label {
          monitor =
          text =  $USER
          color = rgb(186, 194, 222)
          outline_thickness = 0
          dots_size = 0.2 #INFO: Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 #INFO: Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          font_size = 16
          font_family = ${font}
          position =-630, -140
          halign = center
          valign = center
      }

      #INFO: INPUT FIELD
      input-field {
          monitor =
          size = 320, 55
          outline_thickness = 0
          dots_size = 0.2 #INFO: Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 #INFO: Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(255, 255, 255, 0)
          inner_color = rgba(88, 91, 112, 0.4)
          font_color = rgb(205, 214, 244)
          fade_on_empty = false
          font_family = ${font}
          placeholder_text = <i><span foreground="##bac2de">🔒 Enter Pass</span></i>
          hide_input = false
          position = -630, -220
          halign = center
          valign = center
      }

      #INFO: Dragons be here - music widget

      #INFO: Music blur div
      shape {
          monitor =
          size = 350, 110
          color = rgba(88, 91, 112, 0.4)
          rounding = 20
          rotate = 0
          position = -630, -350
          halign = center
          valign = center
          zindex = 1
      }

      #INFO: Music Album Art
      image {
          monitor =
          path = $mpris_art
          size = 86
      	border_size = 3
      	border_color = rgba(255, 255, 255, 0.8)
          rounding = 5
          rotate = 0
          reload_time = 0
          reload_cmd =
          position = 167, -350
          halign = left
          valign = center
          zindex = 5
      }


      #INFO: PLAYER ARTIST
      label {
          monitor =
          text = cmd[update:1000] echo "$($music --artist)"
          color = rgb(186, 194, 222)
          font_size = 12
          font_family = ${font} ExtraBold
          position = 270, -375
          halign = left
          valign = center
          zindex = 5
      }

      #INFO: PLAYER TITLE
      label {
          monitor =
          text = cmd[update:1000] echo "$($music --title)"
          color = rgb(205, 214, 244)
          font_size = 14
          font_family = ${font} ExtraBold
          position = 270, -350
          halign = left
          valign = center
          zindex = 5
      }

      #INFO: PLAYER SOURCE
      label {
          monitor =
          text = cmd[update:1000] echo "$($music --source)" &
          color = rgb(166, 173, 200)
          font_size = 12
          font_family = ${font}
          position = 270, -320
          halign = left
          valign = center
          zindex = 5
      }
    '';
  };
}
