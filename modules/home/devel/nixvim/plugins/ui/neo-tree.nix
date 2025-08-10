{
  programs.nixvim.plugins.neotree = {
    enable = true;
    settings.filesystem.followCurrentFile.enabled = true;
    settings.window.width = 34;
    # keymaps mirroring your Lua bindings
    keymaps = {
      "<leader>fe" = {
        action = ":lua require('neo-tree.command').execute({ toggle = true, dir = require('lazyvim.util').root.get() })<CR>";
        desc = "Explorer NeoTree (Root Dir)";
      };
      "<leader>fE" = {
        action = ":lua require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })<CR>";
        desc = "Explorer NeoTree (cwd)";
      };
      "<leader>be" = {
        action = ":lua require('neo-tree.command').execute({ source = 'buffers', toggle = true })<CR>";
        desc = "Buffer Explorer";
      };
      "<leader>ge" = {
        action = ":lua require('neo-tree.command').execute({ source = 'git_status', toggle = true })<CR>";
        desc = "Git Explorer";
      };
    };
  };
}
