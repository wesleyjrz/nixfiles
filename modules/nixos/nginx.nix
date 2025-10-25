# Pending review
{
  lib,
  config,
  ...
}: let
  cfg = config.extra.nginx;
in {
  options = {
    extra.nginx = {
      enable = lib.mkEnableOption "nginx reverse proxy.";

      acme.boolean = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable ACME.";
      };

      acme.email = lib.mkOption {
        type = lib.types.str;
        default = "dev@wesleyjrz.com";
        description = "E-mail to use for the ACME certificate.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
    };

    security.acme = {
      acceptTerms = cfg.acme;
      defaults.email = cfg.acme.email;
    };

    networking.firewall.allowedTCPPorts = [80 443];

    environment.persistence."/nix/persist/state".directories = [
      "/var/lib/acme"
    ];
  };
}
