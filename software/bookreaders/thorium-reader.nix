{pkgs, ...}: let
  thorium-reader = pkgs.fetchurl {
    url = "https://github.com/edrlab/thorium-reader/releases/download/v3.0.0/Thorium-3.0.0.AppImage";
    sha256 = "<insert-correct-sha256>";
  };
in {
  home.packages = [
    pkgs.appimage-run
    (pkgs.buildFHSUserEnvBubblewrap {
      name = "thorium-reader";
      targetPkgs = pkgs: [thorium-reader];
    })
  ];
}
