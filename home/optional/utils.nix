# Pending review
{pkgs, ...}: {
  home.packages = with pkgs; [
    xxd # inspect binaries
    comma # run programs directly without installing
    edir # batch renaming tool
    entr # run arbitrary commands when files change
    exiftool # read and write metadata info in files
    ripgrep # find regex patterns inside files
    ncdu
    atool
    gnutar
    p7zip
    unrar
    unzip
    zip
  ];

  home.shellAliases = {
    edir = "edir --trash";
    ncdu = "ncdu --color dark";
  };
}
