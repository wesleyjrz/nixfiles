# Pending review
{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.nodejs];

  xdg.configFile."npm/config".text = ''
    ; Set XDG compliant directories
    prefix=${config.xdg.dataHome}/npm
    cache=${config.xdg.cacheHome}/npm
    tmp=/run/user/1000/npm ; $XDG_RUNTIME_DIR
    init-module=${config.xdg.configHome}/npm/config/npm-init.js
  '';

  home.sessionVariables.NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config";

  home.persistence."/nix/persist".directories = [".config/npm"];
}
