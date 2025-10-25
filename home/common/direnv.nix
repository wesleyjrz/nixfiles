# Pending review
{config, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    silent = true;
    nix-direnv.enable = true;
  };
  home.persistence."/nix/persist".directories = [
    ".local/share/direnv"
  ];
}
