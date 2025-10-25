# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.zenpower;
in {
  options = {
    extra.zenpower = {
      enable = lib.mkEnableOption ''
        Zenpower drivers for reading temperature, voltage(SVI2), current(SVI2)
        and power(SVI2) for AMD Zen Family CPUs.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [config.boot.kernelPackages.zenpower];
    boot.blacklistedKernelModules = ["k10temp"];
  };
}
