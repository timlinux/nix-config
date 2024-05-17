#!/usr/bin/env bash

# For manualy building ITK 4.13.1
nix develop .#itk4
git clone git@github.com:InsightSoftwareConsortium/ITK.git
git checkout v4.13.3
cd ITK
rpl '#  error "Dunno about this gcc"' "#   define VCL_GCC_90" Modules/ThirdParty/VNL/src/vxl/vcl/vcl_compiler.h
mkdir build
cd build
#You make need to adjust the path of libminc below

ccmake .. \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_SHARED_LIBS=ON \
    -DITK_FORBID_DOWNLOADS=ON \
    -DITK_USE_SYSTEM_LIBRARIES=ON \
    -DITK_USE_SYSTEM_EIGEN=OFF \
    -DITK_USE_SYSTEM_GOOGLETEST=OFF \
    -DITK_USE_SYSTEM_GDCM=ON \
    -DITK_USE_SYSTEM_MINC=ON \
    -DLIBMINC_DIR=/nix/store/chdd53qpv2vrp9nfm8x91dl1v1nf036c-libminc-2.4.05/lib/cmake \
    -DModule_ITKMINC=ON \
    -DModule_ITKIOMINC=ON \
    -DModule_ITKIOTransformMINC=ON \
    -DModule_SimpleITKFilters=OFF \
    -DModule_ITKVtkGlue=ON \
    -DModule_ITKReview=ON \
    -DModule_MGHIO=OFF \
    -DModule_AdaptiveDenoising=OFF \
    -DModule_GenericLabelInterpolator=OFF
