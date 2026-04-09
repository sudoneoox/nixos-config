# ── Fuzzy finder (Telescope) ──────────────────────────────────────────────
{pkgs, ...}: {
  programs.nvf.settings.vim = {
    # fzf-lua = {
    #   enable = true;
    #   profile = "max-perf";
    # };
    telescope = {
      enable = true;
      setupOpts = {
        defaults.file_ignore_patterns = [
          "flake.lock"
          "node_modules"
          "%.git/"
          "dist/"
          "build/"
          "target/"
          "result/"
          ".direnv/"
          "venv/"
        ];
      };
      extensions = [
        {
          name = "fzf";
          packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
          setup = {fzf = {fuzzy = true;};};
        }
      ];
    };
  };
}
