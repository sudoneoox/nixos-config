# WARN: need to download appimage from the cider website and place it in the filepath
# To get relevant sha256
# nix hash file {ciderAppImage}
# nix hash to-sri --type sha256 <output-from-previous>
{
  pkgs,
  custom_vars,
}: let
  ciderAppImageDir = builtins.toString "/home/${custom_vars.USERNAME}/Desktop";
in
  pkgs.appimageTools.wrapType2 rec {
    pname = "cider";
    version = "3.0.2";

    src = builtins.fetchurl {
      url = "file://${ciderAppImageDir}/${pname}-v${version}-linux-x64.AppImage";
      sha256 = "sha256-XVBhMgSNJAYTRpx5GGroteeOx0APIzuHCbf+kINT2eU=";
    };

    extraInstallCommands = let
      contents = pkgs.appimageTools.extract {inherit pname version src;};
    in ''
      mkdir -p "$out/share/applications"

      # Best-effort icons from the AppImage
      if [ -d "${contents}/usr/share/icons" ]; then
        mkdir -p "$out/share"
        cp -r "${contents}/usr/share/icons" "$out/share"
      fi
      # Some AppImages ship a top-level icon; install it as a fallback
      if [ -f "${contents}/cider.png" ]; then
        install -Dm444 "${contents}/cider.png" "$out/share/pixmaps/cider.png"
      fi

      # Deterministic desktop entry that uses the real wrapper path
      cat > "$out/share/applications/${pname}.desktop" <<EOF
      [Desktop Entry]
      Type=Application
      Name=Cider
      GenericName=Music Player
      Comment=A cross-platform Apple Music client
      Exec=$out/bin/${pname} %U
      TryExec=$out/bin/${pname}
      Icon=cider
      Categories=Audio;AudioVideo;
      StartupWMClass=cider
      MimeType=x-scheme-handler/ame;x-scheme-handler/cider;x-scheme-handler/itms;x-scheme-handler/itmss;x-scheme-handler/musics;x-scheme-handler/music;
      EOF
    '';
    meta = with pkgs.lib; {
      description = "A new look into listening and enjoying Apple Music in style and performance.";
      homepage = "https://cider.sh/";
      platforms = ["x86_64-linux"];
    };
  }
