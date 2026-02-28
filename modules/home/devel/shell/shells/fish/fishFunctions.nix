let
  op_vault = "op://Development";
in {
  programs.fish.functions = {
    #INFO: GPG Encrypt
    gpgenc = {
      description = "Encrypt a file or stdin/text using gpg, copy to clipboard";
      body = ''
        set recipient $argv[1]

        # write passphrase to a secure temp file
        set passfile (mktemp /dev/shm/gpgenc.XXXXXX)
        chmod 600 $passfile
        op item get n4nyqdxkr2gxw5jknz646qdkfu --reveal --fields label=password > $passfile
        or begin
          rm -f $passfile
          echo "⚠ Failed to fetch passphrase from 1Password"
          return 1
        end

        set gpg_opts --encrypt --sign --armor -r $recipient \
          --batch --pinentry-mode loopback --passphrase-file $passfile \
          --trust-model always

        if test (count $argv) -ge 2
          set file $argv[2]
          if not test -f $file
            rm -f $passfile
            echo "⚠ File not found: $file"
            return 1
          end
          gpg $gpg_opts $file
          set -l enc_status $status
          rm -f $passfile
          test $enc_status -eq 0
          and cat "$file".asc | clip
          and rm "$file".asc
          and echo "✓ Copied to clipboard (from file)"

        else if not isatty stdin
          gpg $gpg_opts -o - | clip
          set -l enc_status $pipestatus[1]
          rm -f $passfile
          test $enc_status -eq 0
          and echo "✓ Copied to clipboard (from pipe)"

        else
          rm -f $passfile
          echo "Usage:"
          echo "  gpgenc <recipient> <file>"
          echo "  echo 'text' | gpgenc <recipient>"
          return 1
        end
      '';
    };

    # ─────────────────────────────────────────
    #INFO: 1Password + Age Encryption
    #
    # ─────────────────────────────────────────

    _age_pubkey = {
      description = "Fetch age public key from 1Password";
      body = ''
        op read "${op_vault}/age-identity/public-key"
      '';
    };

    _age_privkey = {
      description = "Fetch age private key from 1Password";
      body = ''
        op read "${op_vault}/age-identity/private-key"
      '';
    };

    enc = {
      description = "Encrypt a file using age (key from 1Password)";
      body = ''
        set input $argv[1]
        set output (test -n "$argv[2]"; and echo $argv[2]; or echo "$input.age")
        age --recipient (_age_pubkey) -o $output $input
        and echo "✓ Encrypted → $output"
        and echo "History session cleared..."
        and history clear-session
      '';
    };

    dec = {
      description = "Decrypt an age-encrypted file (key from 1Password)";
      body = ''
        set input $argv[1]
        set output (test -n "$argv[2]"; and echo $argv[2]; or string replace -r '\.age$' "" $input)
        _age_privkey | age --decrypt -i /dev/stdin -o $output $input
        and echo "✓ Decrypted → $output"
        and echo "History session cleared..."
        and history clear-session
      '';
    };

    encdir = {
      description = "Encrypt an entire folder into a .tar.age archive (key from 1Password)";
      body = ''
        set dir (string trim -r -c / $argv[1])
        set output (test -n "$argv[2]"; and echo $argv[2]; or echo "$dir.tar.age")
        tar -czf - $dir | age --recipient (_age_pubkey) -o $output -
        and echo "✓ Encrypted folder → $output"
        and echo "History session cleared..."
        and history clear-session
      '';
    };

    decdir = {
      description = "Decrypt a .tar.age folder archive (key from 1Password)";
      body = ''
        set input $argv[1]
        set output_dir (test -n "$argv[2]"; and echo $argv[2]; or echo ".")
        _age_privkey | age --decrypt -i /dev/stdin -o - $input | tar -xzf - -C $output_dir
        and echo "✓ Decrypted → $output_dir"
        and echo "History session cleared..."
        and history clear-session
      '';
    };

    mkcd = {
      description = "Create directory and cd into it";
      body = ''
        mkdir -p $argv[1]
        and cd $argv[1]
      '';
    };

    port = {
      description = "Show what's listening on a given port, or list all listening ports";
      body = ''
        if test (count $argv) -eq 0
          ss -tlnp
        else
          lsof -i :$argv[1]
        end
      '';
    };

    take = {
      description = "Extract any archive into a folder of the same name";
      body = ''
        set file $argv[1]
        set dir (string replace -r '\.(tar\.gz|tgz|tar\.bz2|tbz2|tar\.xz|txz|tar\.zst|zip|rar|7z|tar)$' "" (basename $file))

        mkdir -p $dir
        or return 1

        switch $file
          case '*.tar.gz' '*.tgz'
            tar -xzf $file -C $dir
          case '*.tar.bz2' '*.tbz2'
            tar -xjf $file -C $dir
          case '*.tar.xz' '*.txz'
            tar -xJf $file -C $dir
          case '*.tar.zst'
            tar --zstd -xf $file -C $dir
          case '*.tar'
            tar -xf $file -C $dir
          case '*.zip'
            unzip -o $file -d $dir
          case '*.rar'
            unrar x $file $dir/
          case '*.7z'
            7z x $file -o$dir
          case '*'
            echo "⚠ Unknown archive format: $file"
            rm -d $dir
            return 1
        end

        and echo "✓ Extracted → $dir"
        and cd $dir
      '';
    };

    dotenv = {
      description = "Load .env file into current shell environment";
      body = ''
        set file (test -n "$argv[1]"; and echo $argv[1]; or echo ".env")

        if not test -f $file
          echo "⚠ File not found: $file"
          return 1
        end

        for line in (cat $file)
          # skip comments and blank lines
          string match -q -r '^\s*(#|$)' $line; and continue

          # strip 'export ' prefix if present
          set line (string replace -r '^\s*export\s+' "" $line)

          # split on first '='
          set key (string split -m 1 '=' $line)[1]
          set val (string split -m 1 '=' $line)[2]

          # strip surrounding quotes from value
          set val (string replace -r '^["\'](.*)["\']$' '$1' $val)

          set -gx $key $val
        end

        echo "✓ Loaded env from $file"
      '';
    };

    shred-rm = {
      description = "Securely shred and remove file(s)";
      body = ''
        if test (count $argv) -eq 0
          echo "Usage: shred-rm <file> [file...]"
          return 1
        end

        for file in $argv
          if not test -f $file
            echo "⚠ Skipping (not a regular file): $file"
            continue
          end
          shred -vfz -n 5 $file
          and rm -f $file
          and echo "✓ Shredded → $file"
        end
      '';
    };
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
      description = "Type '!\$' to get last command argument";

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
