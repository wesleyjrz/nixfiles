# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.containers;
in {
  options = {
    extra.containers = {
      enable = lib.mkEnableOption "Enable oci containers (podman or docker).";

      type = lib.mkOption {
        type = lib.types.enum ["podman" "docker"];
        default = "podman";
        description = "Whether to use podman or docker as the container engine.";
      };
    };
  };

  config = let
    docker = cfg.type == "docker";
  in
    lib.mkIf cfg.enable {
      virtualisation.podman = {
        enable = !docker;
        dockerCompat = true;
      };

      environment.systemPackages = lib.mkIf docker [pkgs.docker-compose];

      virtualisation.docker = {
        enable = docker;
        extraOptions = "--iptables=false --ip6tables=false"; # HACK: workaround for https://github.com/NixOS/nixpkgs/issues/111852
      };

      environment.sessionVariables.DOCKER_CONFIG = lib.optional docker "$HOME/.config/docker";

      home-manager.sharedModules = [
        {
          home.persistence."/nix/persist".directories = [
            "/var/lib/containers"
          ];
        }
      ];
    };
}
