{
  programs.nixvim.keymaps = [
    # jk -> ESC
    { mode = "i"; key = "jk"; action = "<ESC>"; options.silent = true; options.noremap = true; }

    # Move selected lines J/K (Primeagen style)
    { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options.silent = true; options.noremap = true; }
    { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; options.silent = true; options.noremap = true; }

    # Paste without overwriting default register
    { mode = "x"; key = "<leader>p"; action = "\"_dP"; options.silent = true; options.noremap = true; }

    # Nop out PgUp/PgDn
    { mode = [ "n" "v" "i" ]; key = "<PageUp>"; action = "<Nop>"; }
    { mode = [ "n" "v" "i" ]; key = "<PageDown>"; action = "<Nop>"; }
  ];
}
