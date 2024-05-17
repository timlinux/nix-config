{
  pkgs,
  self,
  stdenv,
  fetchFromGitHub,
  cmake,
  curl,
  libjpeg,
  boost,
  expat,
  fftw,
  gdal,
  geos,
  hdf4,
  hdf5,
  libgeotiff,
  libjpeg_turbo,
  libpng,
  libsvm,
  libtiff,
  mpi,
  muparser,
  netcdf,
  opencv,
  openjpeg,
  proj,
  sqlite,
  tinyxml,
  zlib,
}:
stdenv.mkDerivation rec {
  pname = "otb";
  version = "9.0";

  src = fetchFromGitHub {
    owner = "orfeotoolbox";
    repo = "OTB";
    rev = "9.0.0";
    # nix-shell -p nix-prefetch-git --command "nix-prefetch-git --url https://github.com/orfeotoolbox/OTB/ --rev 9.0.0" | grep "hash is"
    sha256 = "02ykm5r19jmf72niag3w8nwd3yggij37m738xfh1gs8bcj59mpaj";
  };

  buildInputs = [
    cmake
    curl
    libjpeg
    boost
    expat
    fftw
    gdal
    geos
    self.packages."x86_64-linux".itk4 # defined in packages for this flake
    hdf4
    hdf5
    libgeotiff
    libjpeg_turbo
    libpng
    libsvm
    libtiff
    mpi
    muparser
    netcdf
    opencv
    openjpeg
    proj
    sqlite
    tinyxml
    zlib
  ];

  #cmakeFlags = [
  #  "-DEIGEN_HOME=${eigen}"
  #  "-DGDAL_HOME=${gdal}"
  #  "-DPROJ4_HOME=${proj}"
  #];

  #preBuild = ''
  #  ls ..
  #  sed -i '1i# Add additional library paths\nfind_package(JPEG REQUIRED)\nfind_package(ZLIB REQUIRED)' ../CMakeLists.txt
  #'';

  buildPhase = ''
    # Determine the number of CPU cores available
    ncores=$(nproc)
    # Calculate the number of cores to use for the build (-1)
    jval=$((ncores - 1))
    # Execute the build with the calculated number of cores
    cmake --build . -- -j$jval
  '';

  postInstall = ''
    mkdir -p $out/bin
    ls -lahr *
    mv impl/image-gverify $out/bin/gverify
  '';

  meta = {
    description = "Open Source processing of remote sensing images.";
    #license = stdenv.lib.licenses.apache20;
    #maintainers = [stdenv.lib.maintainers.timlinux];
  };
}
