{
  config,
  pkgs,
  ...
}: let
  appName = "QGIS 2.18";
  nixpkgsUrl = "https://github.com/NixOS/nixpkgs/archive/f06d8e0bf4822788f93ed994c4a9e88bda3606c3.tar.gz";
in {
  environment.systemPackages = with pkgs; let
    qgisApp = makeDesktopItem {
      name = "qgis-2.18";
      desktopName = appName;
      genericName = "Geographic Information System";
      exec = ''
        ${pkgs.nix}/bin/nix-shell -p qgis -I nixpkgs=${nixpkgsUrl} --run "qgis"'';
      icon = "qgis";
      categories = ["Science" "Geography"];
      comment = "A Geographic Information System";
      startupWMClass = "qgis";
    };
  in [qgisApp];
}
