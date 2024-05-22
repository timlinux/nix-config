{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation rec {
  pname = "kartoza-plymouth";
  version = "0.0.2";

  src = "./src";

  buildInputs = [
    pkgs.git
  ];

  configurePhase = ''
    mkdir -p $out/share/plymouth/themes/
  '';

  buildPhase = ''
  '';

  installPhase = ''
    cp -r kartoza $out/share/plymouth/themes
    cat kartoza/kartoza.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/kartoza/kartoza.plymouth
  '';
}
