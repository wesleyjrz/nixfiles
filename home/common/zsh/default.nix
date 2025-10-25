# Pending review
{config, ...}: {
  imports = [
    ./options.nix
    ./aliases.nix
    ./abbrevs.nix
    ./plugins.nix
    ./functions.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    enableVteIntegration = true;
    dotDir = config.xdg.configHome;
  };
}
