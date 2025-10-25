# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.sql;
in {
  options = {
    extra.sql = {
      enable = lib.mkEnableOption "MariaDB Database.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    environment.persistence."/nix/persist/state".directories = [
      "/var/lib/mysql"
    ];
  };
}
