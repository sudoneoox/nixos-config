{
  # NOTE:
  # HM can’t encode repeated directives like multiple mouse_map/include entries as an attrset,
  # so we add them verbatim here.
  programs.kitty.extraConfig = ''
    # mouse behavior
    mouse_map left click ungrabbed no-op
    mouse_map ctrl+left click ungrabbed mouse_handle_click selection link prompt
    mouse_map ctrl+left press ungrabbed mouse_selection normal
    mouse_map right press ungrabbed copy_to_clipboard

    # layout details + theme include
    include splits.conf
    include colors.conf
  '';
}
