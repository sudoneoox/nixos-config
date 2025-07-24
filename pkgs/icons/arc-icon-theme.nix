{ lib
, stdenvNoCC
, fetchFromGitHub
, autoreconfHook
, pkg-config
, libxml2
, gtk3
, makeWrapper
, hicolor-icon-theme
}:

stdenvNoCC.mkDerivation rec {
  pname = "arc-icon-theme";
  version = "20161122";

  src = fetchFromGitHub {
    owner = "horst3180";
    repo = "arc-icon-theme";
    rev = "55a575386a412544c3ed2b5617a61f842ee4ec15";
    hash = "sha256-TfYtzwo69AC5hHbzEqB4r5Muqvn/eghCGSlmjMCFA7I=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    libxml2
  ];

  buildInputs = [
    gtk3
    makeWrapper
  ];

  propagatedBuildInputs = [
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  # These fixup steps are slow and unnecessary for this package.
  # Package may install almost 400 000 small files.
  dontPatchELF = true;
  dontRewriteSymlinks = true;

  postPatch = ''
    patchShebangs autogen.sh
  '';

  installPhase = ''
    runHook preInstall

    ./autogen.sh --prefix=$out
    make install

    mkdir -p $out/usr/share/icons
    cp -r $out/share/icons/* $out/usr/share/icons/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Arc icon theme";
    homepage = "https://github.com/horst3180/arc-icon-theme";
    license = licenses.gpl3;
    platforms = platforms.unix;
  };
}
