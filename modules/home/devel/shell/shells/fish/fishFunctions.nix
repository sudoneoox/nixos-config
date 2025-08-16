{
  programs.fish.functions = {
    git-revert-file = {
      description = "Revert single file in git";
      body = ''
        git reset HEAD $argv
        git checkout $argv
      '';
    };
    bak = {
      description = "Copies (backups) file in same folder with .bak extension";
      body = ''
        cp -i "$argv" "$argv.bak"
      '';
    };
    run = {
      description = "Make file executable, then run it";
      body = ''
        chmod +x "$argv"
        shellcheck "./$argv"
        eval "./$argv"
      '';
    };

    # };

    fish_title = {
      description = "Prints directory and currently running command in tab title. `user@host` in prompt when connected via ssh.";

      body = ''
        set -q SSH_CLIENT || set -q SSH_TTY && echo -n "🖧$USER@"(hostname)" "
        if [ "$_" != fish ]
          echo "➤ $_ "
        end
        echo 🖿 (basename (pwd))
      '';
    };
    # Exit code notifier (event)
    show_exit_code = {
      onEvent = "fish_postexec";
      description = "Show exit code on command failure";

      body = ''
        set -l last_status $status
        set -g CMD_START_TIME (date)
        if [ $last_status -ne 0 -a $argv != "" ]
          echo (set_color F92672)"✖ $last_status"
        end
        if [ "$SINGLE_COMMAND" = true ]
          if [ $last_status -ne 0 ]
            read -P "Command failed ↑"
          else
            sleep 0.3
          end
          exit 0
        end
      '';
    };
    # Save dir history for scd (event)
    save_dir = {
      onEvent = "fish_postexec";
      description = "If command was executed if directory, save dir to Ctrl+E history for quick access.";

      body = ''
        test "$last_pwd"!="$PWD"
        and string match -q -r "(^\$|ls|cd|pwd|ll|echo|man)" $argv
        or echo "$PWD" >>~/.local/share/fish/fish_dir_history
        set -g last_pwd "$PWD"
      '';
    };

    "what-did-just-happen" = {
      description = "Show start time, and duration of last executed command";
      body = ''
        echo "Started: $CMD_START_TIME"
        echo "Duration: $CMD_DURATIONms"

      '';
    };

    # INFO:
    # FZF tools
    #  * `Ctrl`+`R` show fzf (fuzzy) history search where you can:
    #    - Super advanched analog or `Ctrl`+`R` in Bash
    #    - Execute previos command
    #    - Edit command before execution
    #    - Delete history entry (very useful for no longer actual commands)
    #    - <img src="https://developer.run/pic/fish_history.png"/>

    fzf-history-widget = {
      description = "Ctrl+R for history";

      body = ''
        history merge
        history | fzf -q (commandline) -e +m --tiebreak=index --sort \
          --preview-window 'up:50%:wrap:hidden' \
          --preview 'echo {}' \
          --bind "left:execute(printf ' commandline %q' {})+cancel+cancel" \
          --bind "right:execute(printf ' commandline %q' {})+cancel+cancel" \
          --bind "del:execute(printf ' history delete %q' {})+cancel+cancel" \
          --bind "ctrl-x:execute(printf {} | xclip -sel clip)+cancel+cancel" \
          --bind "ctrl-a:toggle-preview" \
          --bind "ctrl-e:execute(echo ' eval scd')+cancel+cancel" \
          --header "[⏎] run; [←] edit; [del] delete; [ctrl]+[x] copy; [ctrl]+[a] show full;" \
          | read -l -d \0 result
        and commandline $result
        and commandline -f repaint
        and commandline -f execute
      '';
    };
    search = {
      description = "`CTRL`+`F` Fuzzy recursive search files by name in current directory & append selection to current command";
      body = ''

        if [ $argv == ""]
          find $PWD 2>/dev/null | fzf -q "'" \
            --bind "ctrl-f:execute(echo -e \" search-contents\n\")+cancel+cancel" | read -l result; and commandline -a $result
        else
          find $PWD -iname $argv 2>/dev/null | fzf
        end
      '';
    };
    search-contents = {
      description = "`ALT`+`CTRL`+`F` search (fuzzy) file by contents";

      body = ''
        if type -q ag
          ag --nobreak --no-numbers --noheading --max-count 100000 . 2>/dev/null \
            | fzf -q "'" --header 'Searching file contents' --preview-window 'up:3:wrap' --preview 'echo {} | cut -d ":" -f2' \
            | string split ':' | head -n 1 | read -l result
          and commandline $result
          and commandline -f repaint
        else
          echo "⚠ to speed up search install ag"
          grep -I -H -n -v --line-buffered --color=never -r -e '^$' . | fzf | string split ":" | head -n 1 | read -l result
          and commandline $result
          and commandline -f repaint
        end
      '';
    };

    scd = {
      description = "`Ctrl`+`E` to access most frequently visited directories.";

      body = ''
        cat ~/.local/share/fish/fish_dir_history | freq | fzf -q "'" -e +m --tiebreak=index --bind "ctrl-r:abort" --sort \
          | cut -c9- | read -l result
        and cd $result
        and commandline -f repaint
        and ls
      '';
    };

    update-fzf = {
      description = "Installs or updates fzf";

      body = ''
        set FZF_VERSION (curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/junegunn/fzf-bin/releases/latest | xargs basename)
        curl -L https://github.com/junegunn/fzf-bin/releases/download/$FZF_VERSION/fzf-$FZF_VERSION-linux_amd64.tgz | tar -xz -C /tmp/
        sudo -p "Root password to install fzf: " mv /tmp/fzf /usr/local/bin/fzf
      '';
    };

    freq = {
      description = "Line frequency in piped input. See <https://gist.github.com/rsvp/1859875>";

      body = ''cat 1>| sort -f | uniq -c | sort -k 1nr -k 2f'';
    };

    bind_bang = {
      description = "Type `!!` to get last command";

      body = ''
        switch (commandline -t)
          case "!"
            commandline -t $history[1]
            commandline -f repaint
          case "*"
            commandline -i !
        end
      '';
    };

    bind_dollar = {
      description = "Type `!\$` to get last command argument";

      body = ''
        switch (commandline -t)
          case "!"
            commandline -t ""
            commandline -f history-token-search-backward
          case "*"
            commandline -i '$'
        end
      '';
    };
  };
}
