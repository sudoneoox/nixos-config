
{ lib, stdenv, fetchFromGitHub, go, gtk3, pkg-config, gtk-layer-shell }:

stdenv.mkDerivation rec {
  pname = "hypr-dock";
  version = "unstable-2025-08-05";

  src = fetchFromGitHub {
    owner = "lotos-linux";
    repo = "hypr-dock";
    rev = "f45f22f5fef291b2c0a924af0c54477412d29f7a"; # or latest
    hash = "sha256-0000000000000000000000000000000000000000000="; # fill in after first build
  };

  nativeBuildInputs = [ go pkg-config ];
  buildInputs = [ gtk3 gtk-layer-shell ];

  buildPhase = ''
    make get
    make build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp hypr-dock $out/bin/
  '';

  meta = with lib; {
    description = "Interactive dock panel for Hyprland";
    homepage = "https://github.com/lotos-linux/hypr-dock";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "hypr-dock";
  };
}
