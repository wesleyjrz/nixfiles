# Pending review
{
  lib,
  outputs,
  pkgs,
  ...
}: let
  leviathanPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbJWuY5bCPGvWYi7E8lpifluIBRaz37mpsoE7R/7Wf7 dev@wesleyjrz.com";
  romeoPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWEJK41Bk8u5FLsVlG+X3l4ufm4/8+kC88u9BX+5CNG dev@wesleyjrz.com";
in {
  imports = [
    ./hardware-configuration.nix
    ./services
    ../common
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };

  users.users = {
    root.openssh.authorizedKeys.keys = [leviathanPublicKey romeoPublicKey];
    wesleyjrz.openssh.authorizedKeys.keys = [leviathanPublicKey romeoPublicKey];
  };
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  services.fail2ban.enable = true;

  networking = {
    hostName = "hydra";
    nameservers = ["9.9.9.9" "149.112.112.112"];
  };

  # Workaround for https://github.com/NixOS/nix/issues/6898
  services.logrotate.checkConfig = false;

  # Use linux-zen kernel
  boot.kernelPackages = pkgs.linuxPackages_hardened;

  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
