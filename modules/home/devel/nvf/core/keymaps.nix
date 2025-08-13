{
  programs.nvf.settings.vim = {
    telescope.mappings = {
      findFiles = "<leader>ff";
      liveGrep = "<leader>fg";
      buffers = "<leader>fb";
      helpTags = "<leader>fh";
      resume = null;
      findProjects = "<leader>fp";
      diagnostics = "<leader>fld";
      gitBranches = "<leader>fvb";
      gitBufferCommits = null;
      gitCommits = "<leader>fvc";
      gitStash = "<leader>fvx";
      gitStatus = "<leader>fvs";
      lspDefinitions = "<leader>flD";
      lspDocumentSymbols = "<leader>flsb";
      lspImplementations = "<leader>fli";
      lspReferences = "<leader>flr";
      lspTypeDefinitions = "<leader>flt";
      lspWorkspaceSymbols = "<leader>flsw";
      open = "<leader>ft";
      treesitter = "<leader>fs";
    };

    "lsp".nvim-docs-view.mappings = {
      viewToggle = "<leader>cd";
      viewUpdate = null;
    };

    "lsp".otter-nvim.mappings = {
      toggle = null;
    };

    "lsp".mappings = {
      codeAction = "<leader>ca";
      documentHighlight = "<leader>cH";
      format = "<leader>cf";
      hover = "<leader>ch";
      listDocumentSymbols = "<leader>cS";
      openDiagnosticFloat = "<leader>ce";
      renameSymbol = "<leader>cn";
      signatureHelp = "<leader>cs";

      # +Code -> +Workspaces
      listWorkspaceFolders = "<leader>cwl";
      addWorkspaceFolder = "<leader>cwa";
      removeWorkspaceFolder = "<leader>cwr";
      listWorkspaceSymbols = "<leader>cws";
      listImplementations = "<leader>cgi";

      # +Code -> +Git
      listReferences = "<leader>cgr";
      goToType = "<leader>cgt";
      previousDiagnostic = "<leader>cgp";
      nextDiagnostic = "<leader>cgn";
      goToDefinition = "<leader>cgd";
      goToDeclaration = "<leader>cgD";
      toggleFormatOnSave = null;
    };

    minimap.codewindow.mappings = {
      toggle = "<leader>umt";
      toggleFocus = "<leader>umf";
      close = null;
      open = null;
    };

    visuals.cellular-automaton.mappings = {
      makeItRain = null;
    };

    utility.motion.hop.mappings = {
      hop = "<leader>h";
    };

    "git".git-conflict.mappings = {
      none = "<leader>cG0";
      both = "<leader>cGb";
      ours = "<leader>cGo";
      theirs = "<leader>cGt";
    };

    "git".gitsigns.mappings = {
      previousHunk = "[c";
      nextHunk = "]c";
      stageHunk = "<leader>gSs";
      resetHunk = "<leader>gSr";
      previewHunk = "<leader>gSp";
      blameLine = "<leader>gSb";
      diffThis = "<leader>gSd";
      undoStageHunk = "<leader>gSu";
      toggleBlame = "<leader>gSt";
      diffProject = null;
      resetBuffer = null;
      stageBuffer = null;
      toggleDeleted = "<leader>gSD";
    };

    "lsp".trouble.mappings = {
      locList = "<leader>tl";
      documentDiagnostics = "<leader>td";
      quickfix = "<leader>tq";
      symbols = "<leader>ts";
      lspReferences = "<leader>tr";
      workspaceDiagnostics = null;
    };

    terminal.toggleterm.mappings = {
      open = "<leader>/";
    };
  };

  programs.nvf.settings.vim.keymaps = [
    # INFO: for keybinds not provided by the nvf api and for custom keybinds

    # NOTE: Telescope
    {
      key = "<Leader>fr";
      mode = ["n"];
      action = ":Telescope oldfiles<CR>";
      desc = "Recent files [Telescope]";
    }

    # NOTE: Neo-tree
    {
      key = "<Leader>fe";
      mode = ["n"];
      action = ":Neotree toggle<CR>";
      desc = "Toggle file tree [Neotree]";
    }

    # NOTE: Extra

    # Exit insert mode quick cmd
    {
      key = "jk";
      mode = ["i"];
      action = "<ESC>";
      desc = "Exit insert mode";
    }
    # Primeagen move selected text up or down
    {
      key = "J";
      mode = ["v"];
      action = ":m '>+1<CR>gv=gv";
      desc = "";
    }
    {
      key = "K";
      mode = ["v"];
      action = ":m '<-2<cr>gv=gv";
      desc = "";
    }
    {
      key = "<leader>p";
      mode = ["x"];
      action = "'_dP";
      desc = "";
    }
    # Stay in visual mode whenever indenting selected text
    {
      key = "<";
      mode = ["v"];
      action = "<gv";
      desc = "";
    }
    {
      key = ">";
      mode = ["v"];
      action = ">gv";
      desc = "";
    }
  ];
}
