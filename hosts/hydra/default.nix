{
  lib,
  outputs,
  pkgs,
  ...
}: let
  leviathanPrivateKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbJWuY5bCPGvWYi7E8lpifluIBRaz37mpsoE7R/7Wf7 dev@wesleyjrz.com";
  romeoPrivateKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF1zwqpnLiHhXhhWasEkk1CWNYBY6yuCEFrLPW8IqOtR dev@wesleyjrz.com";

  commonUserConfig = {
    openssh.authorizedKeys.keys = [leviathanPrivateKey romeoPrivateKey];
  };
in {
  imports = [
    ./hardware-configuration.nix
    ./services
    ../common
    ../common/optional/nginx.nix
  ];

  optionals.sql = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };

  users.users = {
    root = lib.mkMerge [commonUserConfig];
    wesleyjrz = lib.mkMerge [commonUserConfig];
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
