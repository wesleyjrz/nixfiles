# Pending review
{config, ...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    defaultOptions = [
      "--height 40%"
      "--border"
      "--highlight-line"
    ];
  };
}
