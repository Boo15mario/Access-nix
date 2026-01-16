{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, gtk4
, wrapGAppsHook4
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
  ];

  buildInputs = [
    gtk4
  ];

  meta = with lib; {
    description = "A gtk4 based app launcher for linux";
    homepage = "https://github.com/boo15mario/access-launcher";
    license = licenses.mit; # TODO: Verify license
    mainProgram = "access-launcher";
  };
}
