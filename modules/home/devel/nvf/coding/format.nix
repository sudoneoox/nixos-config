{
  programs.nvf.settings.vim.formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      format_on_save = {
        # respect your Snacks “Format Save” toggle via vim.b.disableFormatSave
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        lua = ["stylua"];
        python = ["ruff_format" "ruff_fix"]; # or "black" if you prefer
        nix = ["nixfmt"];
        c = ["clang_format"];
        cpp = ["clang_format"];
        markdown = ["prettier"];
      };
    };
  };
}
