#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.base -t abeimler/simple-cppbuilder-raylib:base .

docker build --force-rm=true -f ./Dockerfile.linux -t abeimler/simple-cppbuilder-raylib .

#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="3.7.0"  -t abeimler/simple-cppbuilder-raylib:3.7.0 .
#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="3.5.0"  -t abeimler/simple-cppbuilder-raylib:3.5.0 .
#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="3.0.0"  -t abeimler/simple-cppbuilder-raylib:3.0.0 .
#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="2.6.0"  -t abeimler/simple-cppbuilder-raylib:2.6.0 .
#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="2.5.0"  -t abeimler/simple-cppbuilder-raylib:2.5.0 .

docker build --force-rm=true -f ./Dockerfile.linux -t abeimler/simple-cppbuilder-raylib:linux .

docker build --force-rm=true -f ./Dockerfile.linux \
    --build-arg raylib_cmake_args="-DBUILD_SHARED_LIBS=ON" \
    -t abeimler/simple-cppbuilder-raylib:linux-shared-libs .

#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_cmake_args="-DUSE_EXTERNAL_GLFW=ON" -t abeimler/simple-cppbuilder-raylib:linux-external-glfw .


docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg image_tag="x64-mingw-w64" \
    --build-arg raylib_platform="Desktop" \
    -t abeimler/simple-cppbuilder-raylib:x64-mingw-w64 .
docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg image_tag="x86-mingw-w64" \
    --build-arg raylib_platform="Desktop" \
    -t abeimler/simple-cppbuilder-raylib:x86-mingw-w64 .

docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg image_tag="emscripten" \
    --build-arg raylib_platform="Web" \
    -t abeimler/simple-cppbuilder-raylib:web .


docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi4" \
    --build-arg raylib_platform="DRM" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING=ON" \
    -t abeimler/simple-cppbuilder-raylib:rpi4 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi4" \
    --build-arg raylib_platform="Desktop" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING=ON -DOPENGL_VERSION=2.1" \
    -t abeimler/simple-cppbuilder-raylib:rpi4-desktop .


docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi3" \
    --build-arg raylib_platform="Raspberry Pi" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING=ON" \
    -t abeimler/simple-cppbuilder-raylib:rpi3 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi2" \
    --build-arg raylib_platform="Raspberry Pi" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING=ON" \
    -t abeimler/simple-cppbuilder-raylib:rpi2 .


docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="arm-android" \
    --build-arg raylib_platform="Android" \
    -t abeimler/simple-cppbuilder-raylib:arm-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="arm64-android" \
    --build-arg raylib_platform="Android" \
    -t abeimler/simple-cppbuilder-raylib:arm64-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="x86-android" \
    --build-arg raylib_platform="Android" \
    -t abeimler/simple-cppbuilder-raylib:x86-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg image_tag="x64-android" \
    --build-arg raylib_platform="Android" \
    -t abeimler/simple-cppbuilder-raylib:x64-android .