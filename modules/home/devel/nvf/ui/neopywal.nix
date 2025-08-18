{
  pkgs,
  inputs,
  ...
}: let
  neopywal-from-source = pkgs.vimUtils.buildVimPlugin {
    pname = "neopywal.nvim";
    name = "neopywal";

    # NOTE: Only check the core; dont discover every module
    nvimRequireCheck = ["neopywal"];
    # NOTE: Skip known optional integrations that pull in other plugins
    nvimSkipModule = [
      "neopywal.theme.plugins.barbecue"
      "neopywal.theme.plugins.lualine"
      "neopywal.theme.plugins.bufferline"
      "neopywal.theme.plugins.lightline"
      "neopywal.theme.plugins.clap"
      "neopywal.theme.plugins.airline"
      "neopywal.theme.plugins.feline"
      "neopywal.theme.plugins.reactive"
      "barbecue.theme.neopywal"
      "reactive.presets.neopywal-cursor"
      "reactive.presets.neopywal-cursorline"
      "neopywal.utils.kinds" # usually needs lspkind
    ];

    src = inputs.vimPlugins-neopywal;
  };
in {
  programs.nvf.settings.vim.extraPlugins = {
    neopywal = {
      package = neopywal-from-source;

      setup = ''
        -- Only apply neopywal if the wallust-generated template exists
        local neopywalPath = vim.env.HOME .. "/.cache/wallust/colors_neopywal.vim"
        local f = io.open(neopywalPath, "r")
        if f then
          f:close()

          local ok, neopywal = pcall(require, "neopywal")
          if ok then
            neopywal.setup({
              plugins = {
                colored_indent_levels = false,
                -- Either a palette key (e.g. color8) or a hex string
                scope_color = "",
              },

              -- Use wallust template at ~/.cache/wallust/colors_neopywal.vim
              use_wallust = true,

              -- Optional alternatives (empty -> unused)
              colorscheme_file = "",
              use_palette = "",

              transparent_background = true,
              custom_colors = {},
              custom_highlights = {},
              dim_inactive = true,
              terminal_colors = true,
              show_end_of_buffer = false,
              show_split_lines = true,

              no_italic = false,
              no_bold = false,
              no_underline = false,
              no_undercurl = false,
              no_strikethrough = false,

              styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                variables = { "italic" },
                types = { "italic" },
              },

              default_fileformats = true,
              default_plugins = true,

              fileformats = {
                c_cpp = true,
                c_sharp = true,
              },
            })

            vim.cmd.colorscheme("neopywal")

            -- Watch for wallust template changes if fwatch is installed
            local okfw, fwatch = pcall(require, "fwatch")
            if okfw then
              fwatch.watch(neopywalPath, "colorscheme neopywal")
            end
          end
        end
      '';
    };
  };
}
