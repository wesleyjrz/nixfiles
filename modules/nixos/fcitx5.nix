# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.fcitx5;
in {
  options = {
    extra.fcitx5 = {
      enable = lib.mkEnableOption "fcitx5 input method framework.";
    };
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod.type = "fcitx5";

    i18n.inputMethod.fcitx5 = {
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-m17n
      ];
    };

    i18n.inputMethod.fcitx5.waylandFrontend = true;

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".config/fcitx"
          ".config/fcitx5"
          ".local/share/fcitx5"
        ];
      }
    ];
  };
}
