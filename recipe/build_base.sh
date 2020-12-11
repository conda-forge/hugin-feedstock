set -ex

cp $RECIPE_DIR/CMakeLists.txt .
cp $RECIPE_DIR/hugin1CMakeLists.txt src/hugin1/CMakeLists.txt

mkdir build
cd build

cmake -LAH                              \
    -DCMAKE_BUILD_TYPE="Release"        \
    -DCMAKE_PREFIX_PATH=${PREFIX}       \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}    \
    -DENABLE_GUI=OFF                    \
    ..

make -j${CPU_COUNT}
make install
