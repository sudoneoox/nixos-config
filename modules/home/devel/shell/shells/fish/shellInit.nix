{config, ...}: let
  x = config.x0;
in {
  programs.fish.shellInit = ''
    set -gx SOPS_AGE_KEY_FILE ${x.sopsPath}/key.txt
    set -gx SOPS_AGE_RECIPIENTS ${x.sopsPublicKey}

    set -x FZF_DEFAULT_OPTS --prompt="⌕ "

    # Free Ctrl+C for copy in terminal settings
    stty intr \^C

  '';
}
