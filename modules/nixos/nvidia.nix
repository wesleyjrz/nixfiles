# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.nvidia;
in {
  options = {
    extra.nvidia = {
      enable = lib.mkEnableOption "Nvidia settings.";

      beta = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use beta version";
      };

      open = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Use official open-source NVK vulkan drivers.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      package = lib.mkIf (cfg.beta) config.boot.kernelPackages.nvidiaPackages.beta;

      modesetting.enable = true;
      nvidiaSettings = true;

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      open = cfg.open;
    };

    boot.kernelParams = ["nvidia_drm.fbdev=1"];

    environment.sessionVariables = lib.mkIf (config.extra.wayland.enable) {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      WLR_DRM_NO_ATOMIC = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".files = [
          ".nvidia-settings-rc"
        ];
      }
    ];
  };
}
