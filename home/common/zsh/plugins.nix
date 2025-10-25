# Pending review
{pkgs, ...}: {
  programs.zsh.plugins = [
    # Automatic close bracket pairs
    {
      name = pkgs.zsh-autopair.pname;
      src = pkgs.zsh-autopair.src;
    }

    # fish-like syntax highlighting
    {
      name = pkgs.zsh-syntax-highlighting.pname;
      src = pkgs.zsh-syntax-highlighting.src;
    }
  ];
}
