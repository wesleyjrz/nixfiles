# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.sunshine;
in {
  options = {
    extra.sunshine = {
      enable = lib.mkEnableOption "Game stream host for Moonlight.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      openFirewall = true;

      settings = {
        sunshine_name = config.networking.hostName;
        channels = 3;
        controller = true;
        keyboard = false;
        mouse = false;
        origin_web_ui_allowed = "pc"; # host-only web ui access
        wan_encryption_mode = 2; # mandatory encryption
      };
    };
  };
}
