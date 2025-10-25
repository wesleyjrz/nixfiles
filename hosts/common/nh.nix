# Pending review
{
  programs.nh = {
    enable = true;
    flake = "/home/wesleyjrz/Development/personal/nixfiles";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 4 --keep-since 7d";
    };
  };
}
