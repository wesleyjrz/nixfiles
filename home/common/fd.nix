# Pending review
{
  programs.fd.enable = true;
  home.shellAliases = {
    # List all home files inside the ephemeral root partition
    lst = ''fd --one-file-system --base-directory /home/wesleyjrz --type f --hidden --exclude "{.cache,.local/cache,.local/state}"'';

    # List all system files inside the ephemeral root partition
    lstroot = ''sudo fd --one-file-system --base-directory / --type f --hidden --exclude "{home,tmp,etc/passwd}"'';
  };
}
