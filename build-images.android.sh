#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="arm-android" \
    --build-arg raylib_platform="Android" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    -t abeimler/simple-cppbuilder-raylib:arm-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="arm64-android" \
    --build-arg raylib_platform="Android" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    -t abeimler/simple-cppbuilder-raylib:arm64-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="x86-android" \
    --build-arg raylib_platform="Android" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    -t abeimler/simple-cppbuilder-raylib:x86-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="x64-android" \
    --build-arg raylib_platform="Android" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    -t abeimler/simple-cppbuilder-raylib:x64-android .
