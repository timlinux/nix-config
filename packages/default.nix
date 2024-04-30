self: super: {
  kartoza-plymouth = super.callPackage ./kartoza-plymouth {};
  qgis-latest = super.callPackage ./qgis {};
  tilemaker = super.callPackage ./tilemaker/default.nix {};
  gverify = super.callPackage ./gverify/default.nix {};
}
