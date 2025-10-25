# TODO
{}
# let
#   domain = "vault.wesleyjrz.com";
#   port = 8282;
# in {
#   services.vaultwarden = {
#     enable = true;
#     dbBackend = "mysql";
#     config = {
#       domain = "https://${domain}";
#       signupsAllowed = false;
#       rocketPort = port;
#       passwordIterations = 200000;
#     };
#   };
#
#   services.nginx.virtualHosts."${domain}" = {
#     enableACME = true;
#     forceSSL = true;
#     locations."/" = {
#       proxyPass = "http://127.0.0.1:${toString port}/";
#       proxyWebsockets = true;
#       extraConfig = ''
#         proxy_buffering off;
#       '';
#     };
#   };
# }

