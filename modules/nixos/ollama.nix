# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.ollama;
in {
  options = {
    extra.ollama = {
      enable = lib.mkEnableOption "Local large language models.";

      alpaca = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use Alpaca instead of Open WebUI.";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 8081;
        description = "Port to listen on.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama.enable = true;

    services.open-webui = rec {
      enable = !cfg.alpaca;
      port = cfg.port;
      openFirewall = enable;
    };

    environment.systemPackages = lib.mkIf (cfg.alpaca) [pkgs.alpaca];

    # NOTE: hardcoded for Nvidia only.
    services.ollama.acceleration = lib.mkIf (config.extra.nvidia.enable) "cuda";

    environment.persistence."/nix/persist/state".directories = [
      "/var/lib/private/ollama"
    ];

    home-manager.sharedModules = [
      {
        home.persistence."/nix/persist".directories = [
          ".local/share/com.jeffser.Alpaca"
        ];
      }
    ];
  };
}
