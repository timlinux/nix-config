{
  description = "Kartoza NixOS Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
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
    unstable,
    nixos-generators,
  } @ inputs: let
    system = "x86_64-linux";
    # See https://github.com/mcdonc/.nixconfig/blob/86254905e2d13fc42292ac47fd13310d0c778935/videos/oldpkgs/script.rst
    # And the implementations referenced from software/unstable-apps.nix
    overlay-unstable = final: prev: {
      unstable = import unstable {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "qtwebkit-5.212.0-alpha4"
        ];
      };
    };
    pkgs = import nixpkgs {
      inherit system;
    };
    specialArgs = inputs // {inherit system;};
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

    py = pkgs.python3Packages;
    pyOveride = py.override {
      packageOverrides = self: super: {
        pyqt5 = super.pyqt5.override {
          withLocation = true;
          withSerialPort = true;
        };
      };
    };
    # This is used for creating ISO images, see iso section below
    isoBase = {
      isoImage.squashfsCompression = "gzip -Xcompression-level 1";
      systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce ["multi-user.target"];
      users.users.root.openssh.authorizedKeys.keys = [
        (builtins.readFile ./users/public-keys/id_ed25519_tim.pub)
      ];
    };
    # Import the mkHost function
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
    ## Package Definitions. See
    ## https://determinate.systems/posts/nix-run/
    ## For a basic introduction
    ##
    ######################################################
    #
    # Default package - utilities to help you prepare for setting up a new machine.
    #
    # Run with
    # "nix run"
    # or
    # nix run github:timlinux/nix-config
    # or
    # nix run github:timlinux/nix-config#default
    packages.x86_64-linux.default = pkgs.callPackage ./packages/utils {};
    #
    # Package to help you prepare for setting up a new machine.
    #
    # Run with
    # nix run .#utils
    # or
    # nix run github:timlinux/nix-config#utils

    packages.x86_64-linux.runme = pkgs.writeScriptBin "runme" ''
      echo "Tim nix-config default package"
    '';
    #
    # Package to provide a shell with QGIS Python for headless QGIS work.
    #
    # Run with
    # nix shell .#qgis-python-shell
    # or
    # nix run github:timlinux/nix-config#qgis-python-shell

    packages.x86_64-linux.qgis-python-shell = pkgs.callPackage ./packages/qgis-python-shell {};
    #
    # Package format your disk with ZFS then set up your machine
    #
    # Run with
    # nix run .#setup-zfs-machine
    # or
    # nix run github:timlinux/nix-config#setup-zfs-machine
    packages.x86_64-linux.setup-zfs-machine = pkgs.callPackage ./packages/setup-zfs-machine {};
    #
    # Package QGIS with Tim custom additions
    #
    # Run with
    # nix run .#qgis
    # or
    # nix run github:timlinux/nix-config#qgis
    # or install by doing
    # nix profile install .#qgis
    # and uninstall:
    # nix profile uninstall .#qgis
    #
    packages.x86_64-linux.qgis = pkgs.callPackage ./packages/qgis {};

    #
    # Package tilemaker latest version
    #
    # Run with
    # nix run .#tilemaker
    # or
    # nix run github:timlinux/nix-config#tilemaker
    # or install by doing
    # nix profile install .#tilemaker
    # and uninstall:
    # nix profile uninstall .#tilemaker
    #
    packages.x86_64-linux.tilemaker = pkgs.callPackage ./packages/tilemaker {};

    #
    # Package gverify latest version
    #
    # Run with
    # nix run .#gverify
    # or
    # nix run github:timlinux/nix-config#gverify
    # or install by doing
    # nix profile install .#gverify
    # and uninstall:
    # nix profile uninstall .#gverify
    #
    packages.x86_64-linux.gverify = pkgs.callPackage ./packages/gverify {};
    #
    # Package ITK4 (ITK 5 is too recent for otb 9)
    #
    # Run with
    # nix run .#itk4
    # or
    # nix run github:timlinux/nix-config#itk4
    # or install by doing
    # nix profile install .#itk4
    # and uninstall:
    # nix profile uninstall .#itk4
    #
    packages.x86_64-linux.itk4 = pkgs.callPackage ./packages/itk4 {};
    #
    # Package otb latest version
    #
    # Run with
    # nix run .#otb
    # or
    # nix run github:timlinux/nix-config#otb
    # or install by doing
    # nix profile install .#otb
    # and uninstall:
    # nix profile uninstall .#otb
    #
    packages.x86_64-linux.otb = pkgs.callPackage ./packages/otb {self = self;};
    packages.x86_64-linux.distrobox = pkgs.callPackage ./packages/distrobox {};
    packages.x86_64-linux.kartoza-plymouth = pkgs.callPackage ./packages/kartoza-plymouth {};
    packages.x86_64-linux.kartoza-grub = pkgs.callPackage ./packages/kartoza-grub {};

    #packages.x86_64-linux.whitebox-tools = pkgsmkHost.callPackage ./packages/whitebox-tools {};
    packages.x86_64-linux.iso = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      modules = [
        # you can include your own nixos configuration here, i.e.
        #./hosts/iso-gnome.nix
      ];
      format = "vmware";

      # optional arguments:
      # explicit nixpkgs and lib:
      # pkgs = nixpkgs.legacyPackages.x86_64-linux;
      # lib = nixpkgs.legacyPackages.x86_64-linux.lib;
      # additional arguments to pass to modules:
      # specialArgs = { myExtraArg = "foobar"; };

      # you can also define your own custom formats
      # customFormats = { "myFormat" = <myFormatModule>; ... };
      # format = "myFormat";
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
      # Tim's p14s thinkpad - love this machine!
      crest = make-host "crest";
      # Tim Tuxedo desktop box
      waterfall = make-host "waterfall";
      # Tim headless box
      valley = make-host "valley";
      # Vicky laptop
      plain = make-host "lagoon";
      # Marina laptop
      lagoon = make-host "plain";
      # Virtman manual testbed
      rock = make-host "rock";
      # Jeff - running plasma
      jeff = make-host "jeff";
      # Dorah's Laptop
      atoll = make-host "atoll";
      # Eli's Laptop
      crater = make-host "crater";
      # Automated testbed - test gnome
      test-gnome-full = make-host "test-gnome-full";
      # Automated testbed - test gnome
      test-gnome-minimal = make-host "test-gnome-minimal";
      # Automated testbed - test kde6
      test-kde6 = make-host "test-kde6";
      # Automated testbed - test kde5
      test-kde5 = make-host "test-kde5";
    };

    ######################################################
    ##
    ## Developer environments
    ##
    ######################################################

    # invoke with
    # nix develop
    # or
    # nix develop .#default
    devShells.${system}.default = with pkgs;
      mkShell {
        buildInputs = [
          cmakeCurses
          # A Python interpreter including the 'venv' module is required to bootstrap
          # the environment.
          py.python
          py.requests
          git
          virtualenv
          py.chardet
          py.debugpy
          py.future
          py.gdal
          py.jinja2
          py.matplotlib
          py.numpy
          py.owslib
          py.pandas
          py.plotly
          py.psycopg2
          py.pygments
          py.pyqt5
          #py.pyqt5_with_qtwebkit # Added by Tim for InaSAFE
          py.pyqt-builder
          py.pyqtgraph # Added by Tim for QGIS Animation workbench (should probably be standard)
          py.python-dateutil
          py.pytz
          py.pyyaml
          py.qscintilla-qt5
          py.requests
          py.setuptools
          py.sip
          py.six
          py.sqlalchemy # Added by Tim for QGIS Animation workbench
          py.urllib3

          makeWrapper
          wrapGAppsHook
          #pkgs.wrapQtAppsHook

          gcc
          cmake
          cmakeWithGui
          flex
          bison
          ninja

          draco
          exiv2
          fcgi
          geos
          gsl
          hdf5
          libspatialindex
          libspatialite
          libzip
          netcdf
          openssl
          pdal
          postgresql
          proj
          protobuf
          libsForQt5.qca-qt5
          qscintilla
          libsForQt5.qt3d
          libsForQt5.qtbase
          libsForQt5.qtkeychain
          libsForQt5.qtlocation
          libsForQt5.qtmultimedia
          libsForQt5.qtsensors
          libsForQt5.qtserialport
          #libsForQt5.qtwebkit
          libsForQt5.qtxmlpatterns
          libsForQt5.qwt
          saga # Probably not needed for build
          sqlite
          txt2tags
          zstd
          # See https://discourse.nixos.org/t/python-qt-woes/11808/2
          # Needed to give us functional qt tools in our shell
          qt5.wrapQtAppsHook
          makeWrapper
          bashInteractive
        ];

        shellHook = ''
          echo "🌳 Welcome to the QGIS development environment!"
          setQtEnvironment=$(mktemp --suffix .setQtEnvironment.sh)
          echo "shellHook: setQtEnvironment = $setQtEnvironment"
          makeWrapper "/bin/sh" "$setQtEnvironment" "''${qtWrapperArgs[@]}"
          sed "/^exec/d" -i "$setQtEnvironment"
          source "$setQtEnvironment"
        '';
      };
    # invoke with
    # nix develop .#hugo
    #devShells.${system}.hugo = with pkgs;
    #  mkShell {
    #    buildInputs = [
    #      hugo
    #    ];
    #    shellHook = ''
    #    echo "🌳 Welcome to the HUGO dev environment!"
    #    '';
    #};
  };
}
