{pkgs, ...}: {
  imports = [
    ./mpvScript.nix
  ];

  home.packages = with pkgs; [yt-dlp ffmpeg];

  programs.mpv = {
    enable = true;

    #NOTE: Use the wrapped mpv so we can inject runtime deps (yt-dlp, vapoursynth, etc.)
    package = pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        waylandSupport = true;
        #NOTE: youtubeSupport makes the "ytdl" hook available; I still set ytdl_path to yt-dlp below.
      };
      youtubeSupport = true;
    };

    #NOTE: Handy scripts ("plugins")
    scripts = with pkgs.mpvScripts; [
      mpris # desktop media controls
      youtube-upnext # next video queue
      sponsorblock-minimal # auto-skip sponsor segments
      mpv-cheatsheet
      modernz # modern OSC  WARN: (don’t also enable uosc)
    ];

    # Script-specific knobs live under script-opts/<name>.conf
    scriptOpts = {
      sponsorblock = {
        # Options are sponsor,intro,outro,interaction,selfpromo,music_offtopic
        categories = "sponsor,selfpromo";
        skip_once = true;
        auto_skip = true;
      };
      youtube_upnext = {
        autoplay = true;
        show_playlist = true;
      };
      modernz = {
        scale = 1.0;
        showonpause = true;
      };
    };

    # mpv.conf in Nix form
    config = {
      # GPU / Wayland
      profile = "gpu-hq"; # quality preset
      vo = "gpu-next"; # modern renderer
      gpu-api = "vulkan"; # or "opengl" if Vulkan gives you grief
      gpu-context = "wayland";
      hwdec = "auto-safe"; # safe hardware decode (copy-back when needed)
      # If you want per-GPU tuning, use profiles below.

      # YouTube via yt-dlp (the built-in "ytdl" hook calls this)
      ytdl = true;
      ytdl_path = "${pkgs.yt-dlp}/bin/yt-dlp";

      # 1080p preference (will pick best <=1080; falls back sanely)
      # - First try separate best video<=1080 + best audio
      # - Else try best single-file stream <=1080
      ytdl-format = "bv*[height<=1080]+ba/b[height<=1080]";

      # Buffering for network media
      cache = "yes";
      cache-default = 4000000;

      # UX niceties
      save-position-on-quit = true;
      osc = false; # modernz provides OSC
      cursor-autohide = 1;
      audio-file-auto = "fuzzy";
      sub-auto = "fuzzy";
    };

    # Optional default profiles mpv will auto-apply
    defaultProfiles = ["gpu-hq"];

    # Keybinds (input.conf)
    bindings = {
      "WHEEL_UP" = "seek 5";
      "WHEEL_DOWN" = "seek -5";
      "CTRL+WHEEL_UP" = "add volume 2";
      "CTRL+WHEEL_DOWN" = "add volume -2";
      "Alt+0" = "set window-scale 0.5";
      "Alt+1" = "set window-scale 1.0";
      "Alt+2" = "set window-scale 2.0";
      "g" = "script-binding modernz/toggle"; # example script binding
      "s" = "script-binding sponsorblock/skip";
      "Ctrl+u" = "script-binding youtube_upnext/open_list";
    };

    # Profile blocks you can switch to or auto-activate via conditions
    profiles = {
      # Intel Meteor Lake (xe driver + intel-media-driver)
      "gpu-intel" = {
        profile-desc = "Intel iGPU (VAAPI)";
        hwdec = "vaapi";
        # On Wayland, VAAPI works fine without forcing a device; uncomment if needed:
        # hwdec-device = "/dev/dri/renderD128";
        gpu-api = "vulkan";
      };

      # NVIDIA Ada (offloaded)
      "gpu-nvidia" = {
        profile-desc = "NVIDIA dGPU (NVDEC)";
        # Try nvdec-copy first (stable with Wayland); if you want zero-copy, try `nvdec`
        hwdec = "nvdec-copy";
        gpu-api = "vulkan";
      };
    };
    # Extra raw lines to append to input.conf (optional)
    extraInput = ''
      # Space toggles pause
      SPACE cycle pause
      # Quit gracefully
      ESC quit
    '';
  };
}
