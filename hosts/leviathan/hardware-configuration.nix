# Pending review
{
  lib,
  config,
  modulesPath,
  ...
}: let
  by-label = label: "/dev/disk/by-label/" + label;
  backupVolumeLabel = "system-backup";
  defaultMountOptions = ["compress=zstd" "noatime" "nofail" "x-gvfs-show"];
in {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "cryptd"
  ];

  boot.initrd.kernelModules = ["dm-snapshot"];

  boot.kernelModules = ["kvm-amd"];

  boot.initrd.luks.devices."${backupVolumeLabel}" = {
    device = by-label "crypted-backup";
    allowDiscards = true;
  };

  fileSystems."/backup/leviathan" = {
    device = "/dev/mapper/${backupVolumeLabel}";
    fsType = "btrfs";
    options = ["subvol=leviathan"] ++ defaultMountOptions;
  };

  fileSystems."/backup/hydra" = {
    device = "/dev/mapper/${backupVolumeLabel}";
    fsType = "btrfs";
    options = ["subvol=hydra"] ++ defaultMountOptions;
  };

  fileSystems."/backup/etc" = {
    device = "/dev/mapper/${backupVolumeLabel}";
    fsType = "btrfs";
    options = ["subvol=etc"] ++ defaultMountOptions;
  };

  networking.useDHCP = lib.mkDefault true;

  services.hardware.openrgb.motherboard = "amd";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported Bluetooth adapters.
        Experimental = true;
        FastConnectable = true;
      };
    };
  };

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
