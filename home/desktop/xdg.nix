# Pending review
{config, ...}: {
  xdg = {
    dataHome = "${config.home.homeDirectory}/.local/share";
    cacheHome = "${config.home.homeDirectory}/.local/cache";
    configHome = "${config.home.homeDirectory}/.config";
  };

  home.persistence."/nix/persist".files = [".config/mimeapps.list"];
}
