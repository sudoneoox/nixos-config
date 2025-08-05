
{ lib, buildGoModule, fetchFromGitHub, gtk3, gtk-layer-shell, pkg-config }:

buildGoModule rec {
  pname = "hypr-dock";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "lotos-linux";
    repo = "hypr-dock";
    rev = "6848b2a30212561350532550e4891ff7e8454d05";
    hash = "sha256-sTFR/eVln5YPuNjFTGudMPnFsQGgwU8dtPQSJPAmTTo=";
  };

  vendorHash = "sha256-X/0dJzJQ9xaS+oXOqltvMXh8eSS7MAkINBxf22+jUDg=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ gtk3 gtk-layer-shell ];

  # Remove subPackages to avoid it defaulting to ./main
  # We'll manually cd in buildPhase
  subPackages = [ ];

  # Verbose, controlled build
  buildPhase = ''
    set -x
    runHook preBuild
    cd main
    go build -x -v -o ../hypr-dock .
    runHook postBuild
  '';

  installPhase = ''
    set -x
    runHook preInstall
    install -Dm755 hypr-dock $out/bin/hypr-dock
    runHook postInstall
  '';

  postInstall = ''
    mkdir -p $out/share/hypr-dock
    cp -r configs/* $out/share/hypr-dock/
  '';

  meta = with lib; {
    description = "Interactive Dock Panel for Hyprland";
    homepage = "https://github.com/lotos-linux/hypr-dock";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "hypr-dock";
  };
}

