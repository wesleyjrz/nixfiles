# Pending review
let
  romeoPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWEJK41Bk8u5FLsVlG+X3l4ufm4/8+kC88u9BX+5CNG dev@wesleyjrz.com";
in {
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix
    ./services
    ../common
  ];

  extra.wayland.enable = true;

  extra.nvidia = {
    enable = true;
    beta = true;
  };

  extra = {
    fcitx5.enable = true;
    flatpak.enable = true;
    gaming.enable = true;
    gaming.steam = true;
    gaming.emulators = true;
    it87-sensors.enable = true;
    openrgb.enable = true;
    piper.enable = true;
    pipewire.enable = true;
    sunshine.enable = true;
    via.enable = true;
    virt-manager.enable = true;
    waydroid.enable = true;
    zenpower.enable = true;
  };

  extra.plymouth = {
    enable = true;
    theme = "breeze";
  };

  programs.adb.enable = true;
  services.udisks2.enable = true;

  networking = {
    hostName = "leviathan";

    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.0.100";
        prefixLength = 24;
      }
    ];

    defaultGateway = "192.168.0.1";
    nameservers = ["1.1.1.3" "1.0.0.3"];
  };

  programs.ssh.extraConfig = ''
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_ed25519

    Host gitlab.com
      HostName gitlab.com
      User git
      IdentityFile ~/.ssh/id_ed25519
  '';

  users.users.wesleyjrz.openssh.authorizedKeys.keys = [romeoPublicKey];

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  virtualisation.vmVariant.virtualisation = {
    memorySize = 2048;
    cores = 3;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.05";
}
