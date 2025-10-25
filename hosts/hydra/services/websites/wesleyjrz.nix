# Pending review
let
  domain = "wesleyjrz.com";
in {
  services.nginx.virtualHosts."${domain}" = {
    enableACME = true;
    forceSSL = true;
    root = "/var/www/${domain}";
  };
}
