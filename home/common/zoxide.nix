# Pending review
{config, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    options = [
      "--cmd c"
    ];
  };

  home.sessionVariables._ZO_DATA_DIR = "${config.xdg.cacheHome}/zoxide";

  home.persistence."/nix/persist".directories = [".local/cache/zoxide"];
}
