set -ex

# 2022/04/08 hmaarrfk
# Remove Hugin's custom find functions that don't really work with
# newer packages.
rm -f CMakeModules/FindPNG.cmake
rm -f CMakeModules/FindZLIB.cmake
rm -f CMakeModules/FindOpenEXR.cmake

ls -lah CMakeModules

cp $RECIPE_DIR/CMakeLists.txt .
cp $RECIPE_DIR/hugin1CMakeLists.txt src/hugin1/CMakeLists.txt

# Directory was already built in the hugin-base stage
rm -rf build
mkdir build
cd build

cmake -LAH                              \
    -DCMAKE_BUILD_TYPE="Release"        \
    -DCMAKE_PREFIX_PATH=${PREFIX}       \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}    \
    -DwxWidgets_CONFIG_EXECUTABLE=${PREFIX}/bin/wx-config \
    -DENABLE_GUI=ON                     \
    ..

make -j${CPU_COUNT}
make install
