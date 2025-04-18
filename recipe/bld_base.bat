echo on

del CMakeModules\FindPNG.cmake
del CMakeModules\FindZLIB.cmake
del CMakeModules\FindOpenEXR.cmake

copy %RECIPE_DIR%\CMakeLists.txt .
if errorlevel 1 exit 1

copy %RECIPE_DIR%\hugin1CMakeLists.txt src\hugin1\CMakeLists.txt
if errorlevel 1 exit 1

copy %RECIPE_DIR%\win_bundle.cmake CMakeModules\win_bundle.cmake
if errorlevel 1 exit 1

mkdir build
if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1

cmake -LAH -G Ninja                           ^
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5        ^
    %CMAKE_ARGS%                              ^
    -DCMAKE_BUILD_TYPE="Release"              ^
    -DBUILD_HSI=OFF                           ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%      ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%   ^
    -DwxWidgets_ROOT_DIR=%LIBRARY_PREFIX%     ^
    -DwxWidgets_INCLUDE_DIRS=%LIBRARY_INC%\wx ^
    -DwxWidgets_LIBRARIES=%LIBRARY_INC%\lib   ^
    -DENBLEND_DIR=%LIBRARY_PREFIX%            ^
    -DOPENEXR_BIN_DIR=%LIBRARY_BIN%           ^
    -DHUGIN_BUILDER="conda-forge"             ^
    -DEXIFVTOOL_EXE=%LIBRARY_BIN%\exiftool    ^
    -DEXIV2_DLL=%LIBRARY_BIN%\exiv2.dll       ^
    -DGLEW_DLL=%LIBRARY_BIN%\glew32.dll       ^
    -DJPEG_DLL=%LIBRARY_BIN%\libjpeg.dll      ^
    -DLIBEXPAT_DLL=%LIBRARY_BIN%\libexpat.dll ^
    -DPANO13_DLL=%LIBRARY_BIN%\pano13.dll     ^
    -DPANO13_EXE_DIR=%LIBRARY_BIN%            ^
    -DPNG_DLL=%LIBRARY_BIN%\libpng16.dll      ^
    -DSQLITE3_DLL=%LIBRARY_BIN%\sqlite3.dll   ^
    -DTIFF_DLL=%LIBRARY_BIN%\libtiff.dll      ^
    -DVIGRA_DLL=%LIBRARY_BIN%\vigraimpex.dll  ^
    -DEXIFTOOL_EXE_DIR=%PREFIX%\bin           ^
    -DENABLE_GUI=OFF                          ^
    ..

if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
