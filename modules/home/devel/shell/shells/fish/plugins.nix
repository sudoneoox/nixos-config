{pkgs, ...}: let
  fp = pkgs.fishPlugins;
in {
  programs.fish.plugins = [
    {
      name = "grc";
      src = fp.grc.src;
    }
    {
      name = "z";
      src = fp.z.src;
    }
    {
      name = "nvm";
      src = fp.nvm.src;
    }
    {
      name = "fzf";
      src = fp.fzf.src;
    }
    {
      name = "sponge";
      src = fp.sponge.src;
    }
    {
      name = "puffer";
      src = fp.puffer.src;
    }
    {
      name = "tide";
      src = fp.tide.src;
    }
    {
      name = "autopair";
      src = fp.autopair.src;
    }
  ];
}
