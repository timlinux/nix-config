{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  Security,
}:
rustPlatform.buildRustPackage rec {
  pname = "whitebox_tools";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "jblindsay";
    repo = "whitebox-tools";
    rev = "v${version}";
    hash = "";
  };

  cargoHash = "";

  buildInputs = lib.optional stdenv.isDarwin Security;

  doCheck = false;

  meta = with lib; {
    homepage = "https://jblindsay.github.io/ghrg/WhiteboxTools/index.html";
    description = "An advanced geospatial data analysis platform";
    license = licenses.mit;
    maintainers = [maintainers.mpickering];
  };
}
