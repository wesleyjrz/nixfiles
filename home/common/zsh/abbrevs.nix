# Pending review
{
  programs.zsh.zsh-abbr = {
    enable = true;
    abbreviations = {
      run = "nix run nixpkgs\\#";
      shell = "nix shell nixpkgs\\#";
    };
  };
}
