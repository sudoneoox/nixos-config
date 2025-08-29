# hosts/common/modules/shims/starship-compat.nix
{lib, ...}: {
  options.programs.starship.enableInteractive = lib.mkOption {
    type = lib.types.bool;
    default = true; # default to interactive init; safe & matches what the module expects
    description = ''
      Compatibility shim: some Starship module expects this option but doesn't define it.
      Remove this once upstream fixes their module.
    '';
  };
}
