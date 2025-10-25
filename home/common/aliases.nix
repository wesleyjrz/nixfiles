# Pending review
{config, ...}: {
  home.shellAliases = {
    # Nix
    flake = "nix flake";
    dev = "nix develop";

    # Safer and more verbose commands
    cp = "cp --interactive --verbose";
    mv = "mv --interactive --verbose";
    rmdir = "rmdir --verbose";
    del = "rm --interactive --verbose"; # 'rm' is aliased to trash
    shred = "shred --force -u --verbose";

    # Programs output configuration
    diff = "diff --tabsize=4 --color=auto";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    free = "free --si --human";
    du = "du --human-readable";

    # GNU info vi keys
    info = "info --vi-keys";

    # wget
    wget = "wget --continue --hsts-file='${config.xdg.cacheHome}/wget-history.log'";

    # adb
    adb = "HOME=${config.xdg.dataHome}/android adb";
  };
}
