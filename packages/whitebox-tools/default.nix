{
  lib,
  pkgs,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  cmake,
  freetype,
  Security ? (
    if stdenv.isDarwin
    then pkgs.darwin.apple_sdk.frameworks.Security
    else null
  ),
}:
rustPlatform.buildRustPackage rec {
  pname = "whitebox_tools";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "jblindsay";
    repo = "whitebox-tools";
    rev = "v${version}";
    #hash = "sha256-hCRNMnsPmp6WjNW+VIOA/FG7jRwI9FGpRF02WSyG4Ig=";
    hash = "sha256-DQ7BPRd90GNQVfD5NoVcxoyd2L3WZvIkecmRJVUY1R4=";
  };
  #cargoHash = "sha256-Hi/bvnRlk7zqSWbMKeemTvJCzS08Ro9wEhMaugMcTwY=";
  cargoHash = "sha256-BounjGGhbU5dxNV8WjVDQtV7YONNVRldc/t+wet1Gh8=";

  buildInputs = [
    cmake
    freetype
    (lib.optional stdenv.isDarwin Security)
  ];

  patches = [
    ./ceil.patch
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://jblindsay.github.io/ghrg/WhiteboxTools/index.html";
    description = "An advanced geospatial data analysis platform";
    license = licenses.mit;
    maintainers = [maintainers.mpickering];
  };
}
