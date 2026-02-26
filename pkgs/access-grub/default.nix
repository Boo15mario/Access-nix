{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "access-grub";
  version = "1.0";

  src = ./red-white-grub;

  installPhase = '
    mkdir -p $out
    cp -r ./* $out/
  ';

  meta = with lib; {
    description = "A red and white high-contrast GRUB theme for accessibility.";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
