{
  lib,
  stdenv,
  fetchFromGitHub,
  gcc,
  cmake,
  expat,
  fftw,
  gdcm,
  hdf5,
  hdf5-cpp,
  libjpeg,
  libminc,
  libtiff,
  libpng,
  libX11,
  libuuid,
  xz,
  vtk,
  zlib,
  git,
  cmakeCurses,
  # Cocoa,
}: let
  # Define the legacy Nixpkgs with specific versions of GCC and CMake
  legacyPkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "3281bec7174f679eabf584591e75979a258d8c40"; # replace with a specific commit hash
    sha256 = "a-specific-sha256-hash"; # replace with the sha256 hash of the fetch
  }) {};
  #itkGenericLabelInterpolatorSrc = fetchFromGitHub {
  #  owner = "InsightSoftwareConsortium";
  #  repo = "ITKGenericLabelInterpolator";
  #  rev = "2f3768110ffe160c00c533a1450a49a16f4452d9";
  #  hash = "sha256-Cm3jg14MMnbr/sP+gqR2Rh25xJjoRvpmY/jP/DKH978=";
  #};
  #itkAdaptiveDenoisingSrc = fetchFromGitHub {
  #  owner = "ntustison";
  #  repo = "ITKAdaptiveDenoising";
  #  rev = "24825c8d246e941334f47968553f0ae388851f0c";
  #  hash = "sha256-deJbza36c0Ohf9oKpO2T4po37pkyI+2wCSeGL4r17Go=";
  #};
  #itkSimpleITKFiltersSrc = fetchFromGitHub {
  #  owner = "InsightSoftwareConsortium";
  #  repo = "ITKSimpleITKFilters";
  #  rev = "bb896868fc6480835495d0da4356d5db009592a6";
  #  hash = "sha256-MfaIA0xxA/pzUBSwnAevr17iR23Bo5iQO2cSyknS3o4=";
  #};
in
  stdenv.mkDerivation {
    pname = "itk4";
    version = "4.13.3";

    src = fetchFromGitHub {
      owner = "InsightSoftwareConsortium";
      repo = "ITK";
      rev = "v4.13.3";
      sha256 = "sha256-lcoJ+H+nVlvleBqbmupu+yg+4iZQ4mTs9pt1mQac+xg=";
    };

    postPatch = ''
      substituteInPlace CMake/ITKSetStandardCompilerFlags.cmake  \
        --replace "-march=corei7" ""  \
        --replace "-mtune=native" "" \
        --replace "cmake_minimum_required(VERSION 2.8.3)" "cmake_minimum_required(VERSION 3.5)"
    '';
    #ln -sr ${itkGenericLabelInterpolatorSrc} Modules/External/ITKGenericLabelInterpolator
    #ln -sr ${itkAdaptiveDenoisingSrc} Modules/External/ITKAdaptiveDenoising
    #ln -sr ${itkSimpleITKFiltersSrc} Modules/External/ITKSimpleITKFilters
    cmakeFlags = [
      "-DCMAKE_VERBOSE_MAKEFILE=ON"
      "-DBUILD_EXAMPLES=OFF"
      "-DBUILD_SHARED_LIBS=ON"
      "-DITK_FORBID_DOWNLOADS=ON"
      "-DITK_USE_SYSTEM_LIBRARIES=ON"
      "-DITK_USE_SYSTEM_EIGEN=OFF"
      "-DITK_USE_SYSTEM_GOOGLETEST=OFF"
      "-DITK_USE_SYSTEM_GDCM=ON"
      "-DITK_USE_SYSTEM_MINC=ON"
      "-DLIBMINC_DIR=${libminc}/lib/cmake"
      "-DModule_ITKMINC=ON"
      "-DModule_ITKIOMINC=ON"
      "-DModule_ITKIOTransformMINC=ON"
      "-DModule_SimpleITKFilters=OFF"
      "-DModule_ITKVtkGlue=ON"
      "-DModule_ITKReview=ON"
      "-DModule_MGHIO=OFF"
      "-DModule_AdaptiveDenoising=OFF"
      "-DModule_GenericLabelInterpolator=OFF"
    ];

    nativeBuildInputs = [
      (legacyPkgs.gcc9.overrideAttrs (oldAttrs: {
        src = legacyPkgs.fetchurl {
          url = "https://ftp.gnu.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz"; # replace with the correct URL
          sha256 = "new-sha256-hash"; # replace with the correct hash from nix-prefetch-url
        };
      }))
      (legacyPkgs.cmake.overrideAttrs (oldAttrs: {
        src = legacyPkgs.fetchurl {
          url = "https://cmake.org/files/v3.21/cmake-3.21.3.tar.gz"; # replace with the correct URL
          sha256 = "sha256-0U0G30JlE07kLE1Q9aYMuLRxt7akfajl2RTUndeDeU8="; # replace with the correct hash from nix-prefetch-url
        };
      }))
      xz
      git
    ];
    buildInputs = [
      libX11
      libuuid
      vtk
    ];
    # ++ lib.optionals stdenv.isDarwin [Cocoa];
    propagatedBuildInputs =
      [
        cmakeCurses # Just for debugging
        expat
        fftw
        gdcm
        hdf5
        hdf5-cpp
        libjpeg
        libminc
        libpng
        libtiff
        zlib
      ]
      ++ vtk.propagatedBuildInputs;

    meta = {
      description = "Insight Segmentation and Registration Toolkit";
      homepage = "https://www.itk.org";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [viric];
    };
  }
