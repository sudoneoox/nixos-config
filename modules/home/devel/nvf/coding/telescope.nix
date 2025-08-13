# ── Fuzzy finder (Telescope) ──────────────────────────────────────────────
{pkgs, ...}: {
  programs.nvf.settings.vim.telescope = {
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
}
