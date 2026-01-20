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
  version = "0-unstable-2026-01-16";

  src = fetchFromGitHub {
    owner = "boo15mario";
    repo = "access-launcher";
    rev = "b8e047528c2d91ae6bbc6f31031d1e67908d8f6c";
    hash = "sha256-ScpC6uOZ06UTzyI8Zkp1qsPnG2zllklM5KefkbJdwiA=";
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
    if [ -f assets/icon.png ]; then
      install -Dm644 assets/icon.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    elif [ -f icon.png ]; then
      install -Dm644 icon.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    fi
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "access-launcher";
      desktopName = "Access Launcher";
      exec = "access-launcher";
      icon = "access-launcher";
      categories = [ "Utility" ];
    })
  ];

  meta = with lib; {
    description = "A gtk4 based app launcher for linux";
    homepage = "https://github.com/boo15mario/access-launcher";
    license = licenses.mit; # TODO: Verify license
    mainProgram = "access-launcher";
  };
}
