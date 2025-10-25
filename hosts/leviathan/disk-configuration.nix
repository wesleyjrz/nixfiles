# Pending review
{lib, ...}: let
  device = "nvme0n1";
  defaultMountOptions = ["compress=zstd" "noatime"];
in rec {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/" + device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "100%";
              content = {
                name = "root";
                type = "luks";
                settings.allowDiscards = true;
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = defaultMountOptions;
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = defaultMountOptions;
                };
                "/persist" = {
                  mountpoint = "/nix/persist";
                  mountOptions = defaultMountOptions;
                };
                "/swap" = {
                  mountpoint = "/.swap";
                  mountOptions = ["noatime"];
                  swap.swapfile.size = "64G";
                };
                "/snapshots" = {
                  mountpoint = "/snapshots";
                  mountOptions = defaultMountOptions;
                };
              };
            };
          };
        };
      };
    };
  };
}
