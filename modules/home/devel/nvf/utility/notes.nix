{
  programs.nvf.settings.vim.notes = {
    mind-nvim.enable = true;
    todo-comments = {
      enable = true;
      setupOpts = {
        keywords = {
          FIX = {
            icon = " ";
            color = "error";
            alt = ["FIXME" "BUG" "FIXIT" "ISSUE"];
          };
          TODO = {
            icon = " ";
            color = "info";
          };
          HACK = {
            icon = " ";
            color = "warning";
          };
          WARN = {
            icon = " ";
            color = "warning";
            alt = ["WARNING" "XXX"];
          };
          PERF = {
            icon = " ";
            alt = ["OPTIM" "PERFORMANCE" "OPTIMIZE"];
          };
          NOTE = {
            icon = "";
            color = "hint";
          };
          INFO = {
            icon = " ";
            color = "#00BFFF";
          };
          TEST = {
            icon = "⏲ ";
            color = "test";
            alt = ["TESTING" "PASSED" "FAILED"];
          };
        };
      };
    };
    obsidian.enable = false;
    neorg.enable = false;
    orgmode.enable = false;
  };
}
# NOTE:
# INFO:

