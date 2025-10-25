# Pending review
{
  services.btrbk = {
    instances = {
      # btrbk -c /etc/btrbk/leviathan.conf --dry-run --progress --verbose run
      "leviathan" = {
        onCalendar = "daily";
        settings = {
          timestamp_format = "long";

          snapshot_create = "ondemand";
          snapshot_preserve = "no";
          snapshot_preserve_min = "latest";

          target_preserve = "7d 4w 6m";
          target_preserve_min = "1m";

          volume."/" = {
            subvolume = "/nix/persist";
            snapshot_dir = "snapshots";
            target = "/backup/leviathan";
          };
        };
      };

      # NOTE: disabled.
      # btrbk -c /etc/btrbk/minecraft-server.conf --dry-run --progress --verbose run
      # "minecraft-server" = {
      #   onCalendar = "hourly";
      #   settings = {
      #     ssh_identity = "/home/wesleyjrz/.ssh/leviathan";
      #     ssh_user = "root";
      #     ssh_compression = "yes";
      #
      #     timestamp_format = "long";
      #
      #     snapshot_create = "onchange";
      #     snapshot_preserve = "no";
      #     snapshot_preserve_min = "24h";
      #
      #     target_preserve = "24h 7d 4w 3m";
      #     target_preserve_min = "3m";
      #
      #     volume."ssh://wesleyjrz.com/" = {
      #       subvolume = "var/lib/minecraft";
      #       snapshot_dir = "snapshots";
      #       target = "/backup/hydra";
      #     };
      #   };
      # };

      # NOTE: disabled.
      # btrbk -c /etc/btrbk/mysql-hydra.conf --dry-run --progress --verbose run
      # "mysql-hydra" = {
      #   onCalendar = "hourly";
      #   settings = {
      #     ssh_identity = "/home/wesleyjrz/.ssh/leviathan";
      #     ssh_user = "root";
      #     ssh_compression = "yes";
      #
      #     timestamp_format = "long";
      #
      #     snapshot_create = "onchange";
      #     snapshot_preserve = "no";
      #     snapshot_preserve_min = "24h";
      #
      #     target_preserve = "24h 7d 4w 3m";
      #     target_preserve_min = "3m";
      #
      #     volume."ssh://wesleyjrz.com/" = {
      #       subvolume = "var/lib/mysql";
      #       snapshot_dir = "snapshots";
      #       target = "/backup/hydra";
      #     };
      #   };
      # };
    };
  };
}
