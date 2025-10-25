# Pending review
{config, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      msg-color = true;
      term-osd-bar = true; # Displays a progress bar on the terminal
      cursor-autohide = 5000;
      screenshot-directory = "~/Pictures/screenshots/mpv";
      screenshot-format = "png";

      # Saves the seekbar position on exit
      save-position-on-quit = true;
      watch-later-directory = "${config.xdg.cacheHome}/mpv/watch-later";
      watch-later-options-remove = "fullscreen";

      # Uses a large seekable RAM cache even for local input
      cache = true;
      cache-on-disk = false;
      cache-secs = 900;
      demuxer-max-bytes = "600MiB";
      demuxer-max-back-bytes = "300MiB";

      /*
      Video
      */
      vo = "gpu";
      hwdec = "auto-safe";
      opengl-pbo = false;
      opengl-early-flush = false;
      gpu-shader-cache-dir = "${config.xdg.cacheHome}/mpv/shadercache";
      framedrop = "vo";

      /*
      Audio
      */
      ao = "pipewire";
      volume = 100;
      volume-max = 150;
      audio-display = false; # No video when playing audio files
      audio-channels = "auto-safe";

      /*
      Languages
      */
      alang = "por,pt,eng,en";
      slang = "por,pt,eng,en";
    };
    bindings = {
      # Seeks 10 seconds
      l = "seek 10";
      h = "seek 10";

      # Seeks 5 seconds
      "SHIFT+l" = "seek 1";
      "SHIFT+h" = "seek -1";

      # Disables mouse scrolls
      WHEEL_UP = "ignore";
      WHEEL_DOWN = "ignore";
      WHEEL_LEFT = "ignore";
      WHEEL_RIGHT = "ignore";

      # Disables 9 and 0 for volume
      "9" = "ignore";
      "0" = "ignore";

      # Audio controls using plus and minus keys
      "+" = "add volume +2";
      "-" = "add volume -2";
    };
  };

  home.persistence."/nix/persist".directories = [".local/cache/mpv"];
}
