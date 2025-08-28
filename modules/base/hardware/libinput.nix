{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.derived.isLaptop {
    services = {
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };
  };
}
