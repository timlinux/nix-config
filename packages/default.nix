self: super:
{
  adi1090x-plymouth = super.callPackage ./adi1090x-plymouth { };
  # This will build the LTR version
  #qgis-selfbuild = super.callPackage ./qgis-selfbuild/unwrapped-ltr.nix { };
  # This should build the unstable version
  qgis-selfbuild = super.callPackage ./qgis-selfbuild
 { };
}

