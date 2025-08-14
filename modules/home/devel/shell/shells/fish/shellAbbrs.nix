{
  # INFO:
  # Ignore `ls`, `ll`, and `cd` history. `Ctrl+E` is better way to access previosly visited directories

  programs.fish.shellAbbrs = {
    ls = {expansion = " ls";};
    ll = {expansion = " ll";};
    cd = {expansion = " cd";};
  };
}
