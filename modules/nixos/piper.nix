# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.piper;
in {
  options = {
    extra.piper = {
      enable = lib.mkEnableOption "Piper and ratbagd mouse config tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.piper];
    services.ratbagd.enable = true;
  };
}
