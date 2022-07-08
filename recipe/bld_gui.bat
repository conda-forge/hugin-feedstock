echo on

del CMakeModules\FindPNG.cmake
del CMakeModules\FindZLIB.cmake
del CMakeModules\FindOpenEXR.cmake

copy /Y %RECIPE_DIR%\CMakeLists.txt .
if errorlevel 1 exit 1

:REM I'm really not sure why i have to copy this file into the cmake directory
:REM i should be able to copy it into the modules directory, but that doesn't seem to work
:REM this new file seems to be included in the upcoming version of cmake 3.24.0
:REM https://github.com/Kitware/CMake/commit/2a19231d618482755e9aae981a65680bb1ec1050
copy /Y %RECIPE_DIR%\FindwxWidgets.cmake %BUILD_PREFIX%\Library\share\cmake-3.23\Modules\FindwxWidgets.cmake
if errorlevel 1 exit 1

copy /Y %RECIPE_DIR%\hugin1CMakeLists.txt src\hugin1\CMakeLists.txt
if errorlevel 1 exit 1

copy /Y %RECIPE_DIR%\win_bundle.cmake CMakeModules\win_bundle.cmake
if errorlevel 1 exit 1


:REM This directory was built in the previous phase
mkdir build
:REM if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1

cmake -LAH -G Ninja                           ^
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
    -DENABLE_GUI=ON                           ^
    ..
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
