{
  description = "QGIS Developer Flake";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.qgis = pkgs.qgis;

      devShell.x86_64-linux =
        pkgs.mkShell { buildInputs = [ self.packages.x86_64-linux.qgis pkgs.qgis ]; };
   };
}
