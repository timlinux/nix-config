How to build QGIS on Nixos

cd ~
mkdir -p dev/cpp/QGIS-Console-Build
cd dev/cpp
git clone git@github.com:qgis/QGIS.git
cd QGIS-Console-Build

# The first time you do this, this next step
# will take a long time as it builds all of Qt

NIXPKGS_ALLOW_INSECURE=1 nix-shell --impure 
cmake ../QGIS
# Replace 12 with the number of cores you wish to use
# during compile
make -j12
