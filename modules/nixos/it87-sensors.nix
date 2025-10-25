# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.it87-sensors;
in {
  options = {
    extra.it87-sensors = {
      enable = lib.mkEnableOption "IT87xx superio chip sensors support.";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [config.boot.kernelPackages.it87];
  };
}
