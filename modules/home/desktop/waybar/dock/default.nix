{ ... }:

let
  dockConfigPath = ".config/waybar/dock/config.jsonc";
  dockStylePath = ".config/waybar/dock/style.css";
  dockScriptPath = ".config/hypr/assets/scripts/toggle-dock.sh";
in
{
  xdg.configFile.${dockConfigPath}.text = builtins.toJSON {
    layer = "top";
    position = "bottom";
    height = 40;
    modules-center = [ "wlr/taskbar" ];
    "wlr/taskbar" = {
      icon-size = 20;
      tooltip-format = "{app_name}";
      format = "{app_name}";
    };
  };

  xdg.configFile.${dockStylePath}.text = ''
    window#waybar {
      background: rgba(0,0,0,0.85);
      border-radius: 8px;
      font-family: JetBrainsMono Nerd Font;
      padding: 4px;
    }

    #wlr-taskbar button {
      background: transparent;
      padding: 4px 8px;
      margin: 2px;
      border-radius: 6px;
    }

    #wlr-taskbar button.active {
      background: rgba(33,150,243,0.3);
    }
  '';

  xdg.configFile.${dockScriptPath} = {
    text = ''
      #!/bin/bash
      PID=$(pgrep -f "waybar.*dock/config.jsonc")
      if [ -n "$PID" ]; then
        kill "$PID"
      else
        WAYBAR_CONFIG=~/.config/waybar/dock/config.jsonc \
        WAYBAR_STYLE=~/.config/waybar/dock/style.css \
        waybar &
      fi
    '';
    executable = true;
  };
}
