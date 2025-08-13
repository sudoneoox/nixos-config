{
  programs. zsh = {
    enable = true;
    history = {
      append = true;
      share = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      size = 1000000;
      save = 1000000;
      path = "$HOME/.local/share/zsh/.zsh_history";
    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      export WINIT_X11_SCALE_FACTOR=1
      PATH=$PATH:~/.cargo/bin:~/.local/bin
    '';
  };
}
