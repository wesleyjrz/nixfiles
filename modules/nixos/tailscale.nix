# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.tailscale;
in {
  options = {
    extra.tailscale = {
      enable = lib.mkEnableOption "Tailscale client.";

      loginServer = lib.mkOption {
        type = lib.types.str;
        default = "https://tailscale.wesleyjrz.com";
        description = "Server address to connect.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.tailscale];

    services.tailscale = {
      enable = true;
      extraUpFlags = ["--login-server ${cfg.loginServer}"];
    };

    networking.firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0"];
      allowedTCPPorts = [22];
      allowedUDPPorts = [config.services.tailscale.port];
    };

    environment.persistence."/nix/persist/state".directories = [
      "/var/lib/tailscale"
    ];
  };
}
