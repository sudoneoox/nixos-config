{ pkgs, ... }:
{

  home.file = {
    ".config/fish" = {
      recursive = true;
      source = "${pkgs.sfish}";
    };
  };

  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "z";
          src = pkgs.fishPlugins.z;
        }
        {
          name = "nvm";
          src = pkgs.fishPlugins.nvm;
        }
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf;
        }
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer;
        }
        {
          name = "tide";
          src = pkgs.fishPlugins.tide;
        }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair;
        }
      ];
    };
    bat.enable = true;
    bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';

    };
    zsh = {
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
    lazygit.enable = true;
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
      enableZshIntegration = true;
    };
    ripgrep.enable = true;
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        update_ms = 1000;
        presets = "cpu:0:default mem:0:default net:0:default";
      };
    };
    go.enable = true;
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    lsd = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    grc
    systemctl-tui
    ranger
    wget
    croc
    zip
    unzip
    pciutils
    gnumake
    nvtopPackages.full
    nix-output-monitor
    dig

    python312
    python312Packages.pipx
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    cargo
    nixpkgs-fmt

    ffmpeg
    repomix
    age
    dwt1-shell-color-scripts
    neofetch
    sops
    tldr
    devenv
  ];
}
