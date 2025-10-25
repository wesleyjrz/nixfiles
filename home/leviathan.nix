# Pending review
{pkgs, ...}: {
  imports = [
    ./common
    ./desktop
    ./optional/utils.nix
    ./optional/media-utils.nix
    ./optional/latex.nix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    iconTheme = {
      enable = true;
      light = "COSMIC";
      dark = "COSMIC";
      package = pkgs.cosmic-icons;
    };
    cursor = {
      name = "macOS";
      package = pkgs.apple-cursor;
      size = 24;
    };
    fonts = rec {
      serif = sansSerif;
      sansSerif = {
        name = "IBM Plex Sans";
        package = pkgs.ibm-plex;
      };
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      sizes = {
        applications = 12;
        desktop = 10;
        popups = 12;
        terminal = 20;
      };
    };
    opacity.terminal = 1.0;
    targets.firefox.profileNames = ["default"];
  };
}
