# Pending review
{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [gdb cgdb];
  xdg.configFile."cgdb/cgdbrc".text = ''
    # Default split orientation
    set winsplitorientation="vertical"

    # Highlight searches
    set hlsearch

    # Case insensitive searching
    set ignorecase

    ### Keybindings
    imap <C-g> <Esc>
  '';
  home.sessionVariables.CGDB_DIR = "${config.xdg.configHome}/cgdb";
}
