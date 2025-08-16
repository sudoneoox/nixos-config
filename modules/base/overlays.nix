{outputs, ...}: {
  nixpkgs.overlays = [
    outputs.overlays.modifications
    outputs.overlays.stable-packages
    outputs.overlays.additions
  ];
}
