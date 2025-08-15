{
  programs.kitty.keybindings = {
    #INFO: disable accidental new window via kitty_mod+enter
    "kitty_mod+enter" = "no-op";
    "cmd+enter" = "no-op";

    #INFO: tmux-like window/tab nav + move
    "ctrl+a>x" = "close_window";
    "ctrl+a>]" = "next_window";
    "ctrl+a>[" = "previous_window";
    "ctrl+a>period" = "move_window_forward";
    "ctrl+a>comma" = "move_window_backward";

    #INFO: splits / new tab with cwd (needs shell integration)
    "kitty_mod+t" = "launch --location=hsplit";
    "ctrl+a>c" = "launch --cwd=last_reported --type=tab";
    "ctrl+a>," = "set_tab_title";

    #INFO: font size controls
    "ctrl+equal" = "change_font_size all +2.0";
    "ctrl+plus" = "change_font_size all +2.0";
    "ctrl+kp_add" = "change_font_size all +2.0";
    "ctrl+minus" = "change_font_size all -2.0";
    "ctrl+kp_subtract" = "change_font_size all -2.0";
    "ctrl+0" = "change_font_size all 0";

    #INFO: misc
    "f11" = "toggle_fullscreen";
    "ctrl+a>e" = "no-op";
    "ctrl+a>shift+e" = "launch --type=tab nvim ~/.config/kitty/kitty.conf";

    #INFO: reload + notify
    "ctrl+a>shift+r" = "combine : load_config_file : launch --type=overlay sh -c 'echo \"kitty config reloaded.\"; echo; read -r -p \"Press Enter to exit\"; echo \"\"'";

    "ctrl+a>shift+d" = "debug_config";

    #INFO: kittens
    "ctrl+a>space" = "kitten hints --alphabet asdfqwerzxcvjklmiuopghtybn1234567890 --customize-processing custom-hints.py";
    "f3" = "kitten hints --program '*'";

    #INFO: literal ctrl-a to all windows
    "ctrl+a>ctrl+a" = "send_text all \\x01";

    #INFO: more split/layout/navigation from your conf
    "ctrl+a>shift+minus" = "launch --location=hsplit";
    "ctrl+a>backslash" = "launch --location=vsplit --cwd=last_reported";
    "ctrl+a>shift+backslash" = "launch --location=vsplit";
    "F4" = "launch --location=split";
    "F7" = "layout_action rotate";

    #INFO: move focus/windows
    "shift+up" = "move_window up";
    "shift+left" = "move_window left";
    "shift+right" = "move_window right";
    "shift+down" = "move_window down";
    "ctrl+left" = "neighboring_window left";
    "ctrl+right" = "neighboring_window right";
    "ctrl+up" = "neighboring_window up";
    "ctrl+down" = "neighboring_window down";
    "ctrl+a>h" = "neighboring_window left";
    "ctrl+a>l" = "neighboring_window right";
    "ctrl+a>k" = "neighboring_window up";
    "ctrl+a>j" = "neighboring_window down";

    #INFO: zoom + themes kitten
    "ctrl+a>z" = "kitten zoom_toggle.py";
    "ctrl+a>t" = "kitten themes";

    #INFO: quick tab switching
    "ctrl+a>q" = "focus_visible_window";
    "ctrl+a>1" = "goto_tab 1";
    "ctrl+a>2" = "goto_tab 2";
    "ctrl+a>3" = "goto_tab 3";
    "ctrl+a>4" = "goto_tab 4";
    "ctrl+a>5" = "goto_tab 5";
    "ctrl+a>6" = "goto_tab 6";
    "ctrl+a>7" = "goto_tab 7";
    "ctrl+a>8" = "goto_tab 8";
    "ctrl+a>9" = "goto_tab 9";
    "ctrl+a>0" = "goto_tab 10";

    #INFO: dump session and close OS window
    "ctrl+a>s" = "launch --type=overlay --allow-remote-control ~/.config/kitty/dump-session.sh";
    "ctrl+q" = "close_os_window";
  };
}
