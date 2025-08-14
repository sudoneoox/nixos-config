{
  programs.fish.shellInit = ''
    set -gx SOPS_AGE_KEY_FILE /var/lib/sops-nix/key.txt
    set -gx SOPS_AGE_RECIPIENTS age1cm02yeux0zpgryunwdsf2dya0penm30vj3vcftf698nqsey7yqzsdnt6v2

    set -x FZF_DEFAULT_OPTS --prompt="⌕ "

    # Free Ctrl+C for copy in terminal settings
    stty intr \^C

  '';
}
