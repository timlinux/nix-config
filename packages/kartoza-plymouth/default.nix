{
  pkgs ? import <nixpkgs> {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "kartoza-plymouth";
  version = "0.0.2";

  src = builtins.fetchTarball {
    url = "https://github.com/timlinux/kartoza-plymouth-themes/tarball/master";
    sha256 = "sha256:0lwpvklgw632q8r2fvxq28a85pyxiizhlrfigkc0h50hndp6725k";
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

