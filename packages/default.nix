self: super: {
  kartoza-plymouth = super.callPackage ./kartoza-plymouth {};
  qgis-latest = super.callPackage ./qgis {};
  tilemaker = super.callPackage ./tilemaker/default.nix {};
  gverify = super.callPackage ./gverify/default.nix {};
  whitebox-tools = super.callPackage ./whitebox-tools/default.nix {};
  itk4 = super.callPackage ./itk4/default.nix {};
  otb = super.callPackage ./otb/default.nix {};
}
