self: super:
{
  kartoza-plymouth = super.callPackage ./kartoza-plymouth { };
  # This will build the LTR version
  #qgis-ltr = super.callPackage ./qgis/ltr.nix { };
  # This will build the latest version
  #qgis = super.callPackage ./qgis { };
  # This will build the master version
  qgis-master = super.callPackage ./qgis/master.nix { };
}

