# Pending review
{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  fontconfig,
  freetype,
  libX11,
  libXft,
  harfbuzz,
  gd,
  glib,
  ncurses,
  writeText,
  conf ? null,
  patches ? [],
  extraLibs ? [],
  nixosTests,
}:
stdenv.mkDerivation rec {
  pname = "west";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "wesleyjrz";
    repo = "west";
    rev = "5cadfe2faad63ecb70190f3a5de699d0f06ec2db";
    sha256 = "sha256-9DGy7z7+kBnh5+SWoxa/ZHivgAqpxrIyRC9PV5rT0uI=";
  };

  inherit patches;

  configFile =
    lib.optionalString (conf != null) (writeText "config.def.h" conf);

  postPatch =
    lib.optionalString (conf != null) "cp ${configFile} config.def.h"
    + lib.optionalString stdenv.isDarwin ''
      substituteInPlace config.mk --replace "-lrt" ""
    '';

  strictDeps = true;

  makeFlags = ["PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"];

  nativeBuildInputs = [pkg-config ncurses fontconfig freetype];
  buildInputs = [libX11 libXft harfbuzz gd glib] ++ extraLibs;

  preInstall = ''
    export TERMINFO=$out/share/terminfo
  '';

  installFlags = ["PREFIX=$(out)"];

  passthru.tests.test = nixosTests.terminal-emulators.st;

  meta = with lib; {
    homepage = "https://github.com/wesleyjrz/west";
    description = "[we]st is a very complete build of the simple terminal";
    license = licenses.mit;
    maintainers = with maintainers; [wesleyjrz];
    platforms = platforms.unix;
  };
}
