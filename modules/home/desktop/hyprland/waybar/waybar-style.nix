{config, ...}: let
  x = config.x0;
in {
  programs.waybar.style = ''
    @import url("file://${config.x0.cachePath}/wallust/colors-waybar.css");

    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 10.5px;
      font-weight: 600;
      border-radius: 6px;
      min-height: 0;
      box-shadow: none;
      border: none;
      font-weight: bold;
    }

    #workspaces {
      background-color: @background;
      border: none;
      box-shadow: none;
    }

    #tray {
      margin: 6px 3px;
      background-color: @color0;
      padding: 6px 12px;
      border-radius: 6px;
      border-width: 0px;
    }

    #waybar {
      background-color: @background;
      transition-property: background-color;
      transition-duration: 0.5s;
    }

    #window,
    #clock,
    #custom-power,
    #custom-reboot,
    #bluetooth,
    #battery,
    #pulseaudio,
    #backlight,
    #custom-temperature,
    #memory,
    #cpu,
    #network,
    #disk,
    #custom-lock,
    #custom-wl-gammarelay-temperature {
      border-radius: 4px;
      margin: 6px 3px;
      padding: 6px 12px;
      background-color: @color0;
      color: @background;
    }

    /* accents mapped straight to palette */
    #clock {               background-color: @color4;  }
    #disk {                background-color: @color13; }
    #custom-power {        background-color: @color1;  }
    #custom-reboot {       background-color: @color2;  }
    #bluetooth {           background-color: @color3;  }
    #battery {             background-color: @color13; }
    #pulseaudio {          background-color: @color12; }
    #backlight {           background-color: @color8;  }
    #custom-temperature {  background-color: @color12; }
    #memory {              background-color: @color1;  }
    #cpu {                 background-color: @color1;  }
    #network {             background-color: @color11; }
    #custom-lock {         background-color: @color14; }
    #window {              background-color: @color12; }
    #custom-wl-gammarelay-temperature {  background-color: @color4;  }

    #workspaces button {
      all: initial;
      min-width: 0;
      box-shadow: inset 0 -3px transparent;
      padding: 6px 18px;
      margin: 6px 3px;
      border-radius: 4px;
      background-color: rgba(36, 36, 52, 1.0);
      color: @foreground;
    }

    #workspaces button.active {
      color: @color0;
      background-color: @foreground; /* light chip on dark bar */
    }

    #workspaces button:hover {
      box-shadow: inherit;
      text-shadow: inherit;
      color: @color0;
      background-color: @foreground;
    }

    tooltip {
      border-radius: 8px;
      padding: 16px;
      background-color: mix(@background, @color0, 0.5);
      color: @foreground;
    }

    tooltip label {
      padding: 5px;
      background-color: mix(@background, @color0, 0.5);
      color: @foreground;
    }
  '';
}
