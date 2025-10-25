# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.wg-quick;
in {
  options = {
    extra.wg-quick = {
      enable = lib.mkEnableOption "Wireguard client.";

      publicKey = lib.mkOption {
        type = lib.types.str;
        description = "Server public key.";
      };

      address = lib.mkOption {
        type = lib.types.str;
        description = "Server address.";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 51820;
        description = "Server listen port.";
      };

      interfaceName = lib.mkOption {
        type = lib.types.str;
        default = "server";
        description = "Name for the Wireguard interface.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedUDPPorts = [cfg.port];

    networking.wg-quick.interfaces."wg-${cfg.interfaceName}" = {
      listenPort = cfg.port;

      peers = [
        {
          publicKey = cfg.publicKey;
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = config.address + ":" + toString cfg.port;
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
