{
  description = "QGIS Developer Flake";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    thing1 = {
	thing2 = nixpkgs.legacyPackages.x86_64-linux.cowsay;
    };


  };
}
