{
  description = "Kartoza NixOS Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    home-manager,
    nixos-generators,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    # Overlay for unstable packages
    overlay-unstable = final: prev: {
      unstable = import unstable {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = ["qtwebkit-5.212.0-alpha4"];
      };
    };

    # Importing packages from nixpkgs
    pkgs = import nixpkgs {inherit system;};

    # Special arguments used across packages and configurations
    specialArgs = inputs // {inherit system;};

    # Shared modules for Home Manager and other configurations
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

    # Base configuration for ISO image generation
    isoBase = {
      isoImage.squashfsCompression = "gzip -Xcompression-level 1";
      systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce ["multi-user.target"];
      users.users.root.openssh.authorizedKeys.keys = [
        (builtins.readFile ./users/public-keys/id_ed25519_tim.pub)
      ];
    };

    # Function to create NixOS configurations for each host
    make-host = import ./functions/make-host.nix {
      nixpkgs = nixpkgs;
      overlay-unstable = overlay-unstable;
      shared-modules = shared-modules;
      specialArgs = specialArgs;
      system = system;
    };
  in {
    ######################################################
    ##
    ## Package Definitions
    ##
    ######################################################

    packages.x86_64-linux = {
      default = pkgs.callPackage ./packages/utils {};
      setup-zfs-machine = pkgs.callPackage ./packages/setup-zfs-machine {};
      qgis = pkgs.qgis.overrideAttrs (oldAttrs: rec {
        pythonBuildInputs =
          oldAttrs.pythonBuildInputs
          ++ [pkgs.numpy pkgs.requests pkgs.debugpy pkgs.future pkgs.matplotlib pkgs.pandas pkgs.geopandas pkgs.plotly pkgs.pyqt5_with_qtwebkit pkgs.pyqtgraph pkgs.rasterio pkgs.sqlalchemy];
      });
      tilemaker = pkgs.callPackage ./packages/tilemaker {};
      gverify = pkgs.callPackage ./packages/gverify {};
      itk4 = pkgs.callPackage ./packages/itk4 {};
      otb = pkgs.callPackage ./packages/otb {self = self;};
      distrobox = pkgs.callPackage ./packages/distrobox {};
      kartoza-plymouth = pkgs.callPackage ./packages/kartoza-plymouth {};
      kartoza-grub = pkgs.callPackage ./packages/kartoza-grub {};
      kartoza-cron = pkgs.callPackage ./packages/kartoza-cron {};
      iso = nixos-generators.nixosGenerate {
        inherit pkgs;
        modules = [./installer-configuration.nix ./software/system/kartoza-plymouth.nix ./software/system/kartoza-grub.nix ./software/system/ssh.nix];
        format =
          {
            x86_64-linux = "install-iso";
            aarch64-linux = "sd-aarch64-installer";
          }
          .${system};
      };
    };

    ######################################################
    ##
    ## Configurations for each host we manage
    ##
    ######################################################

    nixosConfigurations = {
      live = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules =
          [
            ({
              config,
              pkgs,
              ...
            }: {nixpkgs.overlays = [overlay-unstable];})
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            isoBase
          ]
          ++ shared-modules
          ++ [./hosts/iso-gnome.nix];
      };
      crest = make-host "crest";
      waterfall = make-host "waterfall";
      valley = make-host "valley";
      plain = make-host "lagoon";
      lagoon = make-host "plain";
      rock = make-host "rock";
      jeff = make-host "jeff";
      atoll = make-host "atoll";
      crater = make-host "crater";
      test-gnome-full = make-host "test-gnome-full";
      test-gnome-minimal = make-host "test-gnome-minimal";
      test-kde6 = make-host "test-kde6";
      test-kde5 = make-host "test-kde5";
    };
  };
}
