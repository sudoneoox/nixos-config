{config, ...}: let
  x = config.x0;
in {
  programs.fish.shellInit = ''
    set -gx SOPS_AGE_KEY_FILE ${config.x0.sopsPath}/key.txt
    set -gx SOPS_AGE_RECIPIENTS ${config.x0.sopsPublicKey}

    set -x FZF_DEFAULT_OPTS --prompt="⌕ "

    # Free Ctrl+C for copy in terminal settings
    stty intr \^C

  '';
}
