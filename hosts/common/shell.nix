# Pending review
{
  lib,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable completion for system packages
  environment.pathsToLink = ["/share/zsh"];
}
