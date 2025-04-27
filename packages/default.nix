self: super: {
  timos-plymouth = super.callPackage ./timos-plymouth {};
  timos-grub = super.callPackage ./timos-grub {};
  kartoza-plymouth = super.callPackage ./kartoza-plymouth {};
  kartoza-grub = super.callPackage ./kartoza-grub {};
  kartoza-cron = super.callPackage ./kartoza-cron/default.nix {};
  tilemaker = super.callPackage ./tilemaker/default.nix {};
  gverify = super.callPackage ./gverify/default.nix {};
  itk4 = super.callPackage ./itk4/default.nix {};
  otb = super.callPackage ./otb/default.nix {};
  qgis-conda = super.callPackage ./qgis-conda/default.nix {};
  jupyterlab-desktop = super.callPackage ./jupyterlab-desktop/default.nix {};
  micromamba-shell = super.callPackage ./micromamba-shell/default.nix {};
}
