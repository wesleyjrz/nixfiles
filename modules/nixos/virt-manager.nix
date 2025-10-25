# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.virt-manager;
in {
  options = {
    extra.virt-manager = {
      enable = lib.mkEnableOption "Virtual machine manager.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;

    environment.persistence."/nix/persist/state".directories = [
      "/var/lib/libvirt"
    ];
  };
}
