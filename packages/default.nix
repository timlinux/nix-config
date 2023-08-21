self: super:
{
  adi1090x-plymouth = super.callPackage ./adi1090x-plymouth { };
  # This will build the LTR version
  qgis-ltr = super.callPackage ./qgis/ltr.nix { };
  # This should build the nopython version
  qgis = super.callPackage ./qgis { };
}

