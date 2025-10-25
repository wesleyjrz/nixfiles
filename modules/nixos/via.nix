# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.via;
in {
  options = {
    extra.via = {
      enable = lib.mkEnableOption "QMK keyboard configurator.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.via];
    services.udev.packages = [pkgs.via];
    hardware.keyboard.qmk.enable = true;

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".config/via-nativia"
        ];
      }
    ];
  };
}
