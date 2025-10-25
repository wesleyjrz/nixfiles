# Pending review
{
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # NOTE: some modules are because of the virtualisation in the remote servers.
  boot.initrd.availableKernelModules = [
    "nvme"
    "ata_piix"
    "uhci_hcd"
    "virtio_pci"
    "sr_mod"
    "virtio_blk"
    "cryptd"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.kernelParams = [];

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-label/LK_ROOT";
    preLVM = true;
    allowDiscards = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=root"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=home"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = ["compress=zstd" "noatime" "subvol=nix"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 3 * 1024; # 3GB
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      port = 2222;
      authorizedKeys = config.users.users.root.openssh.authorizedKeys.keys;
      hostKeys = [/etc/secrets/initrd/ssh_host_ed25519_key];
    };
    postCommands = ''
      # Automatically ask for the password on SSH login
      echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
    '';
  };

  nixpkgs.hostPlatform = "aarch64-linux";

  virtualisation.hypervGuest.enable = true;
}
