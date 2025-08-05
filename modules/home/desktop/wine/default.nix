{...}:
{
    programs.wine = {
        enable = true;
        wineBuild = "wineWow";
      };
      services.flatpak.enable = true;
  }
