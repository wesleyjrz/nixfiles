{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.crypto;
in {
  options = {
    extra.crypto = {
      enable = lib.mkEnableOption "Cryptocurrency software.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [electrum monero-cli];

    networking.firewall.allowedTCPPorts = [18080];

    services.monero = {
      enable = false;
      mining = {
        enable = false;
        address = config.sops.secrets.monero-address.path;
        threads = 2;
      };
    };

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".electrum"
        ];
      }
    ];
  };
}
