{
  description = "Kartoza NixOS Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    unstable,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        nixpkgs.config.permittedInsecurePackages = [
          "qtwebkit-5.212.0-alpha4"
        ];
      };
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

    ######################################################
    ##
    ## Configurations for each host we manage
    ##
    ######################################################
    nixosConfigurations = {
      # Tim's p14s thinkpad - love this machine!
      crest = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/crest.nix];
      };
      # Tim Tuxedo desktop box
      waterfall = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/waterfall.nix];
      };
      # Tim headless box
      valley = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/valley.nix];
      };

      # Virtman manual testbed
      rock = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/rock.nix];
      };
      jeff = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/jeff.nix];
      };
      # Automated testbed - test gnome
      test-gnome = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/test-gnome.nix];
      };
      # Automated testbed - test kde
      test-kde = unstable.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/test-kde.nix];
      };
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
