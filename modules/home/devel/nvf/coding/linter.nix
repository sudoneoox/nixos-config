{
  programs.nvf.settings.vim.diagnostics.nvim-lint = {
    enable = true;
    linters_by_ft = {
      markdown = ["vale"];
      python = ["ruff"];
      javascript = ["eslint_d"];
      typescript = ["eslint_d"];
    };
  };
}
