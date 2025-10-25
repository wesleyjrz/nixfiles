# Pending review
{pkgs ? import <nixpkgs> {}}:
with pkgs; {
  west = callPackage ./west.nix {};
  hwtemp = callPackage ./hardware-temperature.nix {};
  weather = callPackage ./weather.nix {};
}
