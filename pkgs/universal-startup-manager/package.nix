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
  pname = "universal-startup-manager";
  version = "0-unstable-2026-01-16";

  src = fetchFromGitHub {
    owner = "boo15mario";
    repo = "universal-startup-manager";
    rev = "a1f030e321b4dff38d8e14e3e200d81a223a9315";
    hash = "sha256-uQ0VorRU02af5cxMODRWusokqWG9JbwTNstlFv3RIJ4=";
  };

  cargoHash = "sha256-Dr27mzPiSmkeTnmHTDgDnkmThq+AkZ6KFHoFf2645uk=";

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
      name = "universal-startup-manager";
      desktopName = "Universal Startup Manager";
      exec = "universal-startup-manager";
      icon = "universal-startup-manager";
      categories = [ "Utility" ];
    })
  ];

  meta = with lib; {
    description = "A universal startup manager for linux based on gtk4";
    homepage = "https://github.com/boo15mario/universal-startup-manager";
    license = licenses.mit; # TODO: Verify license
    mainProgram = "universal-startup-manager";
  };
}
