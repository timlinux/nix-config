{
  description = "Kartoza NixOS Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Use the same nixpkgs as NixOS
    };
    # See https://geospatial-nix.today/
    # and https://github.com/imincik/geospatial-nix.repo
    geospatial = {
      url = "github:imincik/geospatial-nix.repo/latest";
      #inputs.nixpkgs.follows = "nixpkgs"; # align nixpkgs for consistency
    };
    # See https://github.com/nix-community/nixos-generators?tab=readme-ov-file#using-in-a-flake
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    geospatial,
    nixos-generators,
  } @ inputs: let
    system = "x86_64-linux";

    # Importing packages from nixpkgs
    pkgs = import nixpkgs {
      inherit system;
      # See below for qgisWithExtras definition
      overlays = [
        (final: prev: {
          qgis = throw "Use qgisWithExtras instead of pkgs.qgis";
        })
      ];
    };
    # Special arguments used across packages and configurations
    specialArgs =
      inputs
      // {
        inherit system geospatial;
        qgisWithExtras = self.packages.${system}.qgisWithExtras;
        kartozaThemes = {
          plymouth = ./software/system/kartoza-plymouth.nix; # Correct path to the plymouth theme
          grub = ./software/system/kartoza-grub.nix; # Correct path to the grub theme
        };
      };

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
      systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
      users.users.root.openssh.authorizedKeys.keys = [
        (builtins.readFile ./users/public-keys/id_ed25519_tim.pub)
      ];
    };

    # Function to create NixOS configurations for each host
    make-host = import ./functions/make-host.nix {
      nixpkgs = nixpkgs;
      geospatial = geospatial;
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

    # Default package - utilities to help you prepare for setting up a new machine.
    #
    # Run with:
    # "nix run"
    # or
    # nix run github:timlinux/nix-config
    # or
    # nix run github:timlinux/nix-config#default
    #
    # to include in a config do:
    #
    # { pkgs, ... }: {
    #   nixpkgs.overlays = [(import ../../packages)];
    #   environment.systemPackages = with pkgs; [
    #     qgis
    #   ];
    # }

    packages.x86_64-linux = {
      default = pkgs.callPackage ./packages/utils {};
      setup-zfs-machine = pkgs.callPackage ./packages/setup-zfs-machine {};
      tilemaker = pkgs.callPackage ./packages/tilemaker {};
      gverify = pkgs.callPackage ./packages/gverify {};
      itk4 = pkgs.callPackage ./packages/itk4 {};
      otb = pkgs.callPackage ./packages/otb {self = self;};
      distrobox = pkgs.callPackage ./packages/distrobox {};
      timos-plymouth = pkgs.callPackage ./packages/kartoza-plymouth {};
      timos-grub = pkgs.callPackage ./packages/kartoza-grub {};
      kartoza-plymouth = pkgs.callPackage ./packages/kartoza-plymouth {};
      kartoza-grub = pkgs.callPackage ./packages/kartoza-grub {};
      kartoza-cron = pkgs.callPackage ./packages/kartoza-cron {};
      qgis-conda = pkgs.callPackage ./packages/qgis-conda {};
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
      # Live iso Generation
      # Please read: https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
      # To build:
      # nix build .#nixosConfigurations.live.config.system.build.isoImage
      # To run:
      # qemu-system-x86_64 -enable-kvm -m 8096 -cdrom result/iso/nixos-*.iso
      live = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules =
          [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            isoBase
          ]
          ++ shared-modules
          ++ [./hosts/iso-gnome.nix];
      };
      crest = make-host "crest";
      #  {
      #   plymouth = ./software/system/timos-plymouth.nix; # Correct path to the plymouth theme
      #   grub = ./software/system/timos-grub.nix; # Correct path to the grub theme
      # }; # Tim's p14s thinkpad - love this machine!
      waterfall = make-host "waterfall"; # Tim Tuxedo desktop box
      valley = make-host "valley"; # Tim headless box
      delta = make-host "delta"; # Amy Laptop
      lagoon = make-host "lagoon"; # Vicky laptop
      plain = make-host "plain"; # Marina laptop
      rock = make-host "rock"; # Virtman manual testbed
      jeff = make-host "jeff"; # Jeff - running plasma
      atoll = make-host "atoll"; # Dorah's Laptop
      crater = make-host "crater"; # Eli's Laptop
      island = make-host "island"; # Selmas's Laptop
      mainland = make-host "mainland"; # Lova's Laptop

      test-gnome-full = make-host "test-gnome-full"; # Automated testbed - test gnome
      test-gnome-minimal = make-host "test-gnome-minimal"; # Automated testbed - test gnome
      test-kde6 = make-host "test-kde6"; # Automated testbed - test kde6
      test-kde5 = make-host "test-kde5"; # Automated testbed - test kde5
    };
  };
}
