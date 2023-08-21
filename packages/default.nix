self: super:
{
  adi1090x-plymouth = super.callPackage ./adi1090x-plymouth { };
  # This will build the LTR version
  qgis-ltr = super.callPackage ./qgis/ltr.nix { };
  # This will build the latest version but with QScintilla api disabled (see https://github.com/NixOS/nixpkgs/issues/248239)
  qgis = super.callPackage ./qgis { };
  # This should build the nopython version
  qgis-nopython = super.callPackage ./qgis/nopython.nix { };
}

