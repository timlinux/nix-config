self: super: {
  kartoza-plymouth = super.callPackage ./kartoza-plymouth {};
  kartoza-grub = super.callPackage ./kartoza-grub {};
  qgis-latest =
    super.callPackage ./qgis {
    };
  tilemaker = super.callPackage ./tilemaker/default.nix {};
  gverify = super.callPackage ./gverify/default.nix {};
  whitebox-tools = super.callPackage ./whitebox-tools/default.nix {};
  itk4 = super.callPackage ./itk4/default.nix {};
  otb = super.callPackage ./otb/default.nix {};
  kartoza-cron = super.callPackage ./kartoza-cron/default.nix {};
  dash-to-panel = super.callPackage ./dash-to-panel/default.nix {};
}
