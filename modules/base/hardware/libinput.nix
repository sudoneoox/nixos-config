{
  X0,
  lib,
  ...
}: {
  config = lib.mkIf (X0.SYSTEM.HOST_PROFILE == "laptop") {
    services = {
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };
  };
}
