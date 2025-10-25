# Pending review
{pkgs, ...}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-basic
      dvisvgm
      dvipng # for preview and export as html
      amsmath
      hyperref
      xcolor
      ;
  };
in {
  home.packages = [tex];
}
