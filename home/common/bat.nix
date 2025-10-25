# Pending review
{
  programs.bat = {
    enable = true;
    config = {
      style = "plain";
      italic-text = "always";
      tabs = "4";
    };
  };

  # Set bat as the default man pager
  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bh | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
