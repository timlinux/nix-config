self: super: {
  kartoza-plymouth = super.callPackage ./kartoza-plymouth {};
  kartoza-grub = super.callPackage ./kartoza-grub {};
  kartoza-cron = super.callPackage ./kartoza-cron/default.nix {};
  tilemaker = super.callPackage ./tilemaker/default.nix {};
  gverify = super.callPackage ./gverify/default.nix {};
  itk4 = super.callPackage ./itk4/default.nix {};
  otb = super.callPackage ./otb/default.nix {};
}
