# Pending review
{pkgs, ...}: {
  home.packages = with pkgs; [
    ibm-plex
    ubuntu-classic
    nerd-fonts.jetbrains-mono
    corefonts # Microsoft fonts
    noto-fonts-cjk-sans # Chinese, Japanese, Corean
    noto-fonts-color-emoji
    comic-mono
    comic-relief
    cm_unicode
  ];

  services.xsettingsd = {
    enable = true;
    settings = {
      "Xft/Antialias" = true;
      "Xft/Hinting" = true;
      "Xft/HintStyle" = "hintmedium";
      "Xft/RGBA" = "none";
    };
  };
}
