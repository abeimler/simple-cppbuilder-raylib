#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg image_tag="x64-mingw-w64" \
    --build-arg raylib_platform="Desktop" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    -t abeimler/simple-cppbuilder-raylib:x64-mingw-w64 .

docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg image_tag="x86-mingw-w64" \
    --build-arg raylib_platform="Desktop" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    -t abeimler/simple-cppbuilder-raylib:x86-mingw-w64 .

