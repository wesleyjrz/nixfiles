# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.searx;
in {
  options = {
    extra.searx = {
      enable = lib.mkEnableOption "SearX Search Engine.";

      port = lib.mkOption {
        type = lib.types.port;
        default = 8080;
        description = "Port to listen on.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.searx = {
      enable = true;
      settings = {
        server = {
          port = cfg.port;
          bind_address = "127.0.0.1";
          image_proxy = true;
          method = "POST";
          secret_key = "@SEARX_SECRET_KEY@";
        };
        enabled_plugins = [
          "Open Access DOI rewrite"
          "Hostname replace"
          "Tracker URL remover"
          "Hash plugin"
          "Self Information"
        ];
        search = {
          autocomplete = "google";
          safe_search = 2;
        };
        ui = {
          center_alignment = true;
          hotkeys = "vim";
        };
      };
    };
  };
}
