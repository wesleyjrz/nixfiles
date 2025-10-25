# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.plymouth;
  nixosBreezePlymouth = pkgs.kdePackages.breeze-plymouth.override {
    logoFile = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
    logoName = "nixos";
    osName = config.system.nixos.distroName;
    osVersion = config.system.nixos.release;
  };
in {
  options = {
    extra.plymouth = {
      enable = lib.mkEnableOption "Boot splash screen.";

      theme = lib.mkOption {
        type = lib.types.str;
        default = "breeze";
        description = "Plymouth theme to use from https://github.com/adi1090x/plymouth-themes.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = cfg.theme;
        themePackages = [pkgs.adi1090x-plymouth-themes pkgs.nixos-bgrt-plymouth nixosBreezePlymouth];
      };

      # Silent boot
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
    };
  };
}
