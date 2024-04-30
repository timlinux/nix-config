{
  pkgs,
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
      # nix-shell -p nix-prefetch-git --command "nix-prefetch-git --url https://github.com/pinkmatter/GVerify" | grep "hash is"
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
    ls ..
    sed -i '1i# Add additional library paths\nfind_package(JPEG REQUIRED)\nfind_package(ZLIB REQUIRED)' ../CMakeLists.txt
  '';

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
    description = "A tool that measures the geometric accuracy of a satellite orthorectified image.";
    #license = stdenv.lib.licenses.apache20;
    #maintainers = [stdenv.lib.maintainers.timlinux];
  };
}
