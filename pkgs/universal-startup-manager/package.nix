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
  version = "1.2.0-unstable-2026-01-28";

  src = fetchFromGitHub {
    owner = "boo15mario";
    repo = "universal-startup-manager";
    rev = "cdce08e6f5056abe9a42cd2f9040399aefa63468";
    hash = "sha256-cvYomkDAeSID+r4rwzuPpKeu/nnxL2rkC1RAv+X6R2g=";
  };

  cargoHash = "sha256-k8TNU/w8Ghi2SwE01hWG1tBuDNxWFhlAAkhCkdjp3xk=";

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
    elif [ -f universal-startup-manager.svg ]; then
      install -Dm644 universal-startup-manager.svg $out/share/icons/hicolor/scalable/apps/${pname}.svg
    else
      install -Dm644 ${./icon.svg} $out/share/icons/hicolor/scalable/apps/${pname}.svg
    fi
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "universal-startup-manager";
      desktopName = "Universal Startup Manager";
      comment = meta.description;
      exec = "universal-startup-manager";
      icon = "universal-startup-manager";
      categories = [ "Utility" ];
      startupNotify = true;
    })
  ];

  meta = with lib; {
    description = "A universal startup manager for linux based on gtk4";
    homepage = "https://github.com/boo15mario/universal-startup-manager";
    license = licenses.mit; # TODO: Verify license
    mainProgram = "universal-startup-manager";
  };
}
