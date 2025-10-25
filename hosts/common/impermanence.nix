# Pending review
{inputs, ...}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  boot.initrd.systemd.services.nuke-ephemeral-root = {
    description = "Backup and reset root subvolume";
    wantedBy = [
      "initrd.target"
    ];
    after = [
      "cryptsetup.target"
    ];
    before = [
      "sysroot.mount"
    ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir /btrfs-tmp
      mount /dev/pool/root /btrfs-tmp
      if [[ -e /btrfs-tmp/root ]]; then
          mkdir -p /btrfs-tmp/old-roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs-tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs-tmp/root "/btrfs-tmp/old-roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs-tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs-tmp/old-roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs-tmp/root
      sync
      umount /btrfs-tmp
    '';
  };

  fileSystems."/nix/persist".neededForBoot = true;
  fileSystems."/etc/ssh".neededForBoot = true; # for agenix

  environment.persistence."/nix/persist/state" = {
    hideMounts = true;
    directories = [
      "/etc/ssh"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/keys/secret_file";
        parentDirectory = {mode = "u=rwx,g=,o=";};
      }
    ];
  };
}
