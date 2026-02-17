{
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  programs.fish.shellInit =
    ''
      set -Ux PATH /home/${x.identity.username}/.local/bin $PATH

      set -gx SOPS_AGE_KEY_FILE ${x.sopsPath}/key.txt
      set -gx SOPS_AGE_RECIPIENTS ${x.sopsPublicKey}

      set -x FZF_DEFAULT_OPTS --prompt="⌕ "

      # Free Ctrl+C for copy in terminal settings
      stty intr \^C
    ''
    + lib.optionalString x.derived.isArch ''
      # >>> mamba initialize >>>
      # !! Contents within this block are managed by 'micromamba shell init' !!
      set -gx MAMBA_EXE "/home/${x.identity.username}/.local/bin/micromamba"
      set -gx MAMBA_ROOT_PREFIX "/home/${x.identity.username}/micromamba"
      $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
      # <<< mamba initialize <<<
    ''
    + lib.optionalString (x.system.security."1password") ''
      set -Ux SSH_AUTH_SOCK /home/.1password/agent.sock
    '';
}
