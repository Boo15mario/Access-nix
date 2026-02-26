{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "access-os-artwork";
  version = "1.0";

  src = ./assets;

  installPhase = '
    # Install Wallpapers
    mkdir -p $out/share/backgrounds/access-os
    cp wallpaper-dark.png $out/share/backgrounds/access-os/

    # Install Logo
    mkdir -p $out/share/icons/hicolor/512x512/apps
    cp logo.png $out/share/icons/hicolor/512x512/apps/access-os-logo.png

    # Create GNOME background XML (so it shows up in settings)
    mkdir -p $out/share/gnome-background-properties
    cat > $out/share/gnome-background-properties/access-os.xml <<EOF
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>access-OS Dark</name>
    <filename>$out/share/backgrounds/access-os/wallpaper-dark.png</filename>
    <options>zoom</options>
    <pcolor>#000000</pcolor>
    <scolor>#000000</scolor>
    <shade_type>solid</shade_type>
  </wallpaper>
</wallpapers>
EOF
  ';

  meta = with lib; {
    description = "Official branding, wallpapers, and icons for access-OS.";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
