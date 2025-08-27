{X0, ...}: {
  programs.fish.shellInit = ''
    set -gx SOPS_AGE_KEY_FILE ${X0.SOPS_PATH}/key.txt
    set -gx SOPS_AGE_RECIPIENTS ${X0.SOPS_PUBLIC_KEY}

    set -x FZF_DEFAULT_OPTS --prompt="⌕ "

    # Free Ctrl+C for copy in terminal settings
    stty intr \^C

  '';
}
