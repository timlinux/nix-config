{
  pkgs ? import <nixpkgs> {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "kartoza-plymouth";
  version = "0.0.2";

  src = builtins.fetchTarball {
    url = "https://github.com/timlinux/kartoza-plymouth-themes/tarball/master";
    sha256 = "sha256:195rfcwgihxd63gqyzc80s0fys0c7aj8np9q3jmri9d5z4id9kpg";
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

