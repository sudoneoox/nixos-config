let
  MOD_KEY = "ctrl+shift";
in {
  programs.kitty.settings = {
    #INFO: General
    scrollback_lines = 8000;
    paste_actions = "quote-urls-at-prompt";
    strip_trailing_spaces = "never";
    select_by_word_characters = "@-./_~?&=%+#INFO:";
    show_hyperlink_targets = "yes";
    remote_kitty = "if-needed";
    share_connections = "yes";

    #INFO: Window size & layouts
    remember_window_size = "yes";
    initial_window_width = 640;
    initial_window_height = 400;
    enabled_layouts = "splits,stack,fat,tall,grid";
    window_resize_step_cells = 2;
    window_resize_step_lines = 2;
    window_border_width = "0.5pt";
    visual_window_select_characters = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    confirm_os_window_close = -1;

    #INFO: Tab bar
    tab_bar_style = "powerline";
    tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}:{'🇿' if layout_name == 'stack' and num_windows > 1 else ''}{title}";

    #INFO: Colors/background
    background_opacity = 1.0;
    background_image = "none";
    background_image_layout = "tiled";
    background_image_linear = "no";
    dynamic_background_opacity = "yes";

    #INFO: Control & term
    allow_remote_control = "yes";
    allow_hyperlinks = "yes";
    term = "xterm-256color";

    #INFO: Mod key
    kitty_mod = MOD_KEY;

    #INFO: Sessions
    startup_session = "session.conf";
  };
}
