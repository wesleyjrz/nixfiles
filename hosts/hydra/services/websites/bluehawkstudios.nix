# Pending review
let
  domain = "bluehawkstudios.net";
in {
  services.nginx.virtualHosts."${domain}" = {
    enableACME = true;
    forceSSL = true;
    root = "/var/www/${domain}";
  };
}
