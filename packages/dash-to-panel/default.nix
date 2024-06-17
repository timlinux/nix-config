{
  pkgs,
  gnome3,
}:
pkgs.stdenv.mkDerivation rec {
  pname = "dash-to-panel";
  version = "40";

  src = ./source;

  buildInputs = [
    gnome3.gnome-shell
    pkgs.glib
    pkgs.git
    pkgs.gettext
  ];

  installPhase = ''
    # Copy remaining files to the output directory
    mkdir -p $out/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com
    cp -r $src/* $out/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com
    #glib-compile-schemas --strict --targetdir=$tmpSchemasDir $out/share/gnome-shell/extensions/dash-to-panel@jderose9.github.comp schemas
  '';

  meta = with pkgs.lib; {
    description = "Dash to Panel GNOME Extension v${version}";
    homepage = "https://github.com/home-sweet-gnome/dash-to-panel";
    license = licenses.gpl3;
    maintainers = with maintainers; [yourname];
  };
}
