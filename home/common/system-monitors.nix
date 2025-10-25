# Pending review
{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    smartmontools # tools for monitoring health of hard drives
    dmidecode # system hardware information (DMI Table)
    lshw # detailed hardware information
    lm_sensors
    dysk # fancy df alternative
  ];

  home.shellAliases = {
    df = "dysk";
  };

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      update_ms = 1000;
      theme_background = false;
      disks_filter = lib.concatStringsSep " " [
        "/"
        "/backup"
      ];
    };
  };
}
