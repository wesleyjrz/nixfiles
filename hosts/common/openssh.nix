# Pending review
{lib, ...}: {
  services.openssh = {
    enable = true;
    ports = [22];
    openFirewall = true;
    settings = {
      PermitRootLogin = lib.mkDefault "no";

      # Require public key authentication for better security
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
