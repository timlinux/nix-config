{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
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
}: let
  system = stdenv.hostPlatform.system;
  legacyPkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "3281bec7174f679eabf584591e75979a258d8c40";
    sha256 = "bBz4/T/zBzv9Xi5XUlFDeosmSNppLaCQTizMKSksAvk=";
  }) {inherit system;};
in
  stdenv.mkDerivation {
    pname = "itk4";
    version = "4.13.3";

    src = fetchFromGitHub {
      owner = "InsightSoftwareConsortium";
      repo = "ITK";
      rev = "v4.13.3";
      sha256 = "lcoJ+H+nVlvleBqbmupu+yg+4iZQ4mTs9pt1mQac+xg=";
    };

    postPatch = ''
      substituteInPlace Modules/ThirdParty/VNL/src/vxl/vcl/vcl_compiler.h \
        --replace "#  error \"Dunno about this gcc\"" "#   define VCL_GCC_90"
    '';

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
          url = "https://ftp.gnu.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz";
          sha256 = "sha256-Uliptq/pRjwuVrnoNVsaS+4SXKgouAePkQMDvC75H6Y=";
        };
      }))
      # Use CMake from current pkgs instead of legacy pkgs to avoid patching issues
      pkgs.cmake
      xz
      git
    ];
    buildInputs = [
      libX11
      libuuid
      vtk
    ];
    propagatedBuildInputs =
      [
        cmakeCurses
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
