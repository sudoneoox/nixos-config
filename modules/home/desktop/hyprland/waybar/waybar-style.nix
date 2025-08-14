{username, ...}: {
  programs.waybar.style = ''
    @import url("file:///home/${username}/.cache/wallust/colors-waybar.css");

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
      background-color: @w_surface;
      border: none;
      box-shadow: none;
    }

    #tray {
      margin: 6px 3px;
      background-color: @w_surface;
      padding: 6px 12px;
      border-radius: 6px;
      border-width: 0px;
    }

    #waybar {
      background-color: @w_base;
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
    #custom-lock {
      border-radius: 4px;
      margin: 6px 3px;
      padding: 6px 12px;
      background-color: @w_surface;
      color: @w_base;
    }

    #clock {               background-color: @w_prim;   }
    #disk {                background-color: @w_magenta;}
    #custom-power {        background-color: @w_alert;  }
    #custom-reboot {       background-color: @w_ok;     }
    #bluetooth {           background-color: @w_warn;   }
    #battery {             background-color: @w_magenta;}
    #pulseaudio {          background-color: @w_sec;    }
    #backlight {           background-color: @w_muted;  }
    #custom-temperature {  background-color: @w_sec;    }
    #memory {              background-color: @w_alert;  }
    #cpu {                 background-color: @w_alert;  }
    #network {             background-color: @w_orange; }
    #custom-lock {         background-color: @w_cyan;   }
    #window {              background-color: @w_sec;    }

    #workspaces button {
      all: initial;
      min-width: 0;
      box-shadow: inset 0 -3px transparent;
      padding: 6px 18px;
      margin: 6px 3px;
      border-radius: 4px;
      background-color: rgba(36, 36, 52, 1.0);
      color: @w_text;
    }


    #workspaces button.active {
      color: @w_surface;
      background-color: @w_text; /* light chip on dark bar */
    }

    #workspaces button:hover {
      box-shadow: inherit;
      text-shadow: inherit;
      color: @w_surface;
      background-color: @w_text;
    }

    tooltip {
      border-radius: 8px;
      padding: 16px;
      background-color: mix(@w_base, @w_surface, 0.5);
      color: @w_text;
    }

    tooltip label {
      padding: 5px;
      background-color: mix(@w_base, @w_surface, 0.5);
      color: @w_text;
    }

  '';
}
