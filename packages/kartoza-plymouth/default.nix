{
  pkgs ? import <nixpkgs> {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "kartoza-plymouth";
  version = "0.0.1";

  src = builtins.fetchGit {
    url = "https://github.com/timlinux/kartoza-plymouth-themes.git";
  };

  buildInputs = [
    pkgs.git
  ];

  configurePhase = ''
mkdir -p $out/share/plymouth/themes/
  '';

  buildPhase = ''
  '';

  installPhase = ''
cp -r pack_1/flame $out/share/plymouth/themes
cat pack_1/flame/flame.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/flame/flame.plymouth
cp -r pack_1/kartoza $out/share/plymouth/themes
cat pack_1/kartoza/kartoza.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/kartoza/kartoza.plymouth
  '';
}

