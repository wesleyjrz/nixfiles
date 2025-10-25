# Pending review
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    wget
    coreutils-full
    inetutils
    findutils
    file
  ];
}
