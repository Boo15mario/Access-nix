{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, gtk4
, wrapGAppsHook4
, copyDesktopItems
, makeDesktopItem
}:

rustPlatform.buildRustPackage rec {
  pname = "access-launcher";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "boo15mario";
    repo = "access-launcher";
    rev = "e5451cff9b323ce4c6767247371af4e4f7a77cfc";
    hash = "sha256-8q4clUppasAXpMDskhZd11hIwPKkz9siSk7MgW2yxN8=";
  };

  cargoHash = "sha256-Yri+MWl28/N36MPweGQBOBZSmyC3L89anXe5kwITIxY=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
    copyDesktopItems
  ];

  buildInputs = [
    gtk4
  ];

  postInstall = ''
    mkdir -p $out/share/icons/hicolor/512x512/apps
    mkdir -p $out/share/icons/hicolor/scalable/apps
    if [ -f assets/icon.png ]; then
      install -Dm644 assets/icon.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    elif [ -f icon.png ]; then
      install -Dm644 icon.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    else
      install -Dm644 ${./icon.svg} $out/share/icons/hicolor/scalable/apps/${pname}.svg
    fi
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "access-launcher";
      desktopName = "Access Launcher";
      comment = meta.description;
      exec = "access-launcher";
      icon = "access-launcher";
      categories = [ "Utility" ];
      startupNotify = true;
    })
  ];

  meta = with lib; {
    description = "A gtk4 based app launcher for linux";
    homepage = "https://github.com/boo15mario/access-launcher";
    license = licenses.mit; # TODO: Verify license
    mainProgram = "access-launcher";
  };
}
