{custom_vars, ...}: {
  programs.fish.shellInit = ''
    set -gx SOPS_AGE_KEY_FILE ${custom_vars.SOPS_PATH}/key.txt
    set -gx SOPS_AGE_RECIPIENTS ${custom_vars.SOPS_PUBLIC_KEY}

    set -x FZF_DEFAULT_OPTS --prompt="⌕ "

    # Free Ctrl+C for copy in terminal settings
    stty intr \^C

  '';
}
