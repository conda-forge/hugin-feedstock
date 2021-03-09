set -ex

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
