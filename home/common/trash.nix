{pkgs, ...}: {
  home.packages = [pkgs.trashy];
  home.shellAliases = {
    rm = "trash";
    restore = "trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force";
  };
  home.persistence."/nix/persist".directories = [".local/share/Trash"];
}
