# NOTE: disabled.
{}
# {config, ...}: let
#   domain = "firefly.wesleyjrz.com";
#   port = 3306;
# in {
#   sops.secrets."hydra/firefly" = {
#     owner = "firefly-iii";
#     group = "nginx";
#   };
#
#   services.firefly-iii = {
#     enable = true;
#     enableNginx = true;
#     virtualHost = domain;
#     settings = {
#       DB_HOST = "localhost";
#       DB_PORT = port;
#       DB_CONNECTION = "mysql";
#       DB_DATABASE = "firefly";
#       DB_USERNAME = "root";
#       APP_KEY_FILE = config.sops.secrets."hydra/firefly".path;
#       DEFAULT_LOCALE = "pt_BR.UTF-8";
#       TZ = config.time.timeZone;
#     };
#   };
#
#   services.nginx.virtualHosts."${domain}" = {
#     enableACME = true;
#     forceSSL = true;
#   };
#
#   services.mysql = let
#     inherit (config.services.firefly-iii) settings;
#   in {
#     ensureDatabases = [settings.DB_DATABASE];
#     ensureUsers = [
#       {
#         name = settings.DB_USERNAME;
#         ensurePermissions = {"${settings.DB_DATABASE}.*" = "ALL PRIVILEGES";};
#       }
#     ];
#   };
# }

