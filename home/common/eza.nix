# Pending review
{pkgs, ...}: {
  home.packages = [pkgs.eza];
  home.shellAliases = {
    l = "eza -G --icons --group-directories-first --ignore-glob='*~'";
    ls = "eza -G --all --icons --group-directories-first --ignore-glob='*~'";
    ll = "eza -l --all --icons --group-directories-first --ignore-glob='*~'";
    lr = "eza -T --all --icons --group-directories-first --ignore-glob='*~|.git'";
  };
}
