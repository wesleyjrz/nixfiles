# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.pipewire;
in {
  options = {
    extra.pipewire = {
      enable = lib.mkEnableOption "Pipewire sound server.";

      jack = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable jack support.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = cfg.jack;
    };

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".local/state/wireplumber"
        ];
      }
    ];
  };
}
