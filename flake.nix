{
    description = "Kartoza NixOS Flakes";

    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
      home-manager.url = "github:nix-community/home-manager/release-23.11";
    };

    outputs = { self, home-manager, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      specialArgs = inputs // { inherit system; };
      shared-modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    in {
        packages.x86_64-linux.default = pkgs.writeScriptBin "runme" ''
          echo "Tim nix-config default package"
        ''; 
        
        packages.x86_64-linux.setup-zfs-machine = pkgs.callPackage ./packages/setup-zfs-machine{ };
        # An app that uses the `runme` package
        #apps.default = {
        #    type = "app";
        #    program = "${self.packages.${system}.runme}/bin/runme";
        #};
        nixosConfigurations = {
          crest = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs;
	    system = system;
            modules = shared-modules ++ [ ./hosts/crest.nix ];
          };
          test = nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs;
	    system = system;
            modules = shared-modules ++ [ ./hosts/test.nix ];
          };
        };
      };
}
