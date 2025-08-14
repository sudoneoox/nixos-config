{...}: {
  programs.fish.binds = {
    # Ctrl+U → clear the commandline
    "ctrl-u".command = ''commandline ""'';

    # Ctrl+R → fzf history (fallback to history-search-backward if fzf missing)
    "ctrl-r".command = ''if type -q fzf; fzf-history-widget; else; history-search-backward; end'';

    # Ctrl+F → file search UI (noop if fzf missing)
    "ctrl-f".command = ''if type -q fzf; search; end'';

    # Ctrl+E → smart cd chooser (scd)
    "ctrl-e".command = ''scd'';

    # Esc+Ctrl+F → content search (ripgrep/ag/grep via your function)
    "alt-ctrl-f".command = ''search-contents'';

    # ! → expand last command token
    "exclamation".command = ''bind_bang'';

    # $ → history token search
    "dollar".command = ''bind_dollar'';

    # Esc → exit only when SINGLE_COMMAND=true (otherwise does nothing)
    # NOTE: This *overrides* default Esc behavior to a no-op when SINGLE_COMMAND is not set.
    # If you want to keep default Esc behavior, define this bind only in that mode (see note below).
    "escape".command = ''test "$SINGLE_COMMAND" = true; and exit 0'';
  };
}
