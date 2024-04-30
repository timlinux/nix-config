{
  stdenv,
  fetchFromGitHub,
  cmake,
  zlib,
  libjpeg,
  proj,
  gdal,
  eigen,
}:
stdenv.mkDerivation rec {
  pname = "gverify";
  version = "1.0";

  src =
    fetchFromGitHub {
      owner = "pinkmatter";
      repo = "GVerify";
      rev = "master";
      sha256 = "0knd5ha4aizwhh5cq7adhjpn97lhzskwnbfj1ddy3vl1zv358g8h";
    }
    + "/src";

  buildInputs = [
    cmake
    zlib
    libjpeg
    proj
    gdal
    eigen
  ];

  cmakeFlags = [
    "-DEIGEN_HOME=${eigen}"
    "-DGDAL_HOME=${gdal}"
    "-DPROJ4_HOME=${proj}"
  ];

  preBuild = ''
    sed -i '1i# Add additional library paths\nfind_package(JPEG REQUIRED)\nfind_package(ZLIB REQUIRED)' CMakeLists.txt
  '';

  meta = with stdenv.lib; {
    description = "A tool that measures the geometric accuracy of a satellite orthorectified image.";
    license = licenses.apache20;
    maintainers = [maintainers.timlinux];
  };
}
