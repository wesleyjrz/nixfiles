# Pending review
# FIXME
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.openrgb;
in {
  options = {
    extra.openrgb = {
      enable = lib.mkEnableOption "OpenRGB lighting control.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
  };
}
