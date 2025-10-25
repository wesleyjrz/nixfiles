let
  domain = "tailscale.wesleyjrz.com";
  port = 1717;
  derpPort = port - 1;
in rec {
  networking.firewall.allowedUDPPorts = [derpPort];

  containers.headscale = {
    autoStart = true;
    privateNetwork = true;
    config = {...}: {
      services.headscale = {
        enable = true;
        port = port;
        address = "127.0.0.1";
        settings = {
          server_url = "https://${domain}";

          logtail.enabled = false;
          log.level = "warn";
          metrics_listen_addr = "127.0.0.1:${toString (port + 1)}";

          dns = {
            magic_dns = true;
            base_domain = "tail.scale";
          };

          prefixes.v4 = "100.64.0.0/10";
          prefixes.v6 = "fd7a:115c:a1e0::/48";

          derp.server = {
            enable = true;
            region_id = 999;
            stun_listen_addr = "0.0.0.0:${toString derpPort}";
          };
        };
      };
    };
  };

  services.nginx.virtualHosts."${domain}" = {
    enableACME = true;
    forceSSL = true;
    locations = {
      "/" = {
        proxyPass = "http://localhost:${toString containers.headscale.services.headscale.port}";
        proxyWebsockets = true;
      };
      "/metrics" = {
        proxyPass = "http://${containers.headscale.services.headscale.settings.metrics_listen_addr}/metrics";
      };
    };
  };
}
