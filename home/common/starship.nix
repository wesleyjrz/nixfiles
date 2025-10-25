# Pending review
{config, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    settings = {
      character = {
        success_symbol = "[󰊠 ❯](bold cyan)";
        error_symbol = "[󰊠 ❯](bold red)";
      };
    };
  };
  programs.zsh.initContent = "eval $(starship init zsh)";
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
}
