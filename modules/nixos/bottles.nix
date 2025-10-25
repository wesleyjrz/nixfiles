# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.bottles;
in {
  options = {
    extra.bottles = {
      enable = lib.mkEnableOption "Bottles wineprefix manager + Wine.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (bottles.override {removeWarningPopup = true;})
      winetricks
      wineWowPackages.waylandFull
    ];

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".wine"
          ".local/share/bottles"
        ];
      }
    ];
  };
}
