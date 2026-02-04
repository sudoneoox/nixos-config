{
  custom,
  lib,
  ...
}: let
  x = custom.x0;
in {
  config = lib.mkIf x.system.security."1password" {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [x.identity.username];
    };
  };
}
