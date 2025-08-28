{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf (x.system.hostProfile == "laptop") {
    services = {
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };
  };
}
