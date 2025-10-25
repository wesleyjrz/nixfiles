# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.waydroid;
in {
  options = {
    extra.waydroid = {
      enable = lib.mkEnableOption "Waydroid Android Container.";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.waydroid.enable = true;

    environment.persistence."/nix/persist/state".directories = [
      "/var/lib/waydroid"
    ];
    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".local/share/waydroid"
        ];
      }
    ];
  };
}
