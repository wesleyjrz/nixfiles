# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.flatpak;
in {
  options = {
    extra.flatpak = {
      enable = lib.mkEnableOption "Enable flatpak support.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    environment.persistence."/nix/persist/state".directories = [
      "/var/lib/flatpak"
    ];

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".var"
          ".local/share/flatpak"
        ];
      }
    ];
  };
}
