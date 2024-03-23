{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
      myhost = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
        config = {
          services.xserver.enable = true;
          services.xserver.displayManager.gdm.enable = true;
          services.xserver.desktopManager.gnome.enable = true;
          environment.gnome.excludePackages = (with pkgs; [
            gnome-photos
            gnome-tour
          ]) ++ (with pkgs.gnome; [
            cheese # webcam tool
            gnome-music
            gedit # text editor
            epiphany # web browser
            geary # email reader
            gnome-characters
            tali # poker game
            iagno # go game
            hitori # sudoku game
            atomix # puzzle game
            yelp # Help view
            gnome-contacts
            gnome-initial-setup
          ]);
          programs.dconf.enable = true;
          environment.systemPackages = with pkgs; [
            gnome.gnome-tweaks
          ]
        };
      };
    };
  };
}
