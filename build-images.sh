#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.base -t abeimler/simple-cppbuilder-raylib:base .

docker build --force-rm=true -f ./Dockerfile.linux -t abeimler/simple-cppbuilder-raylib .

docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="3.7.0"  -t abeimler/simple-cppbuilder-raylib:3.7.0 .
docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="3.5.0"  -t abeimler/simple-cppbuilder-raylib:3.5.0 .
docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="3.0.0"  -t abeimler/simple-cppbuilder-raylib:3.0.0 .
#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="2.6.0"  -t abeimler/simple-cppbuilder-raylib:2.6.0 .
#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_branch="2.5.0"  -t abeimler/simple-cppbuilder-raylib:2.5.0 .

docker build --force-rm=true -f ./Dockerfile.linux -t abeimler/simple-cppbuilder-raylib:linux .

docker build --force-rm=true -f ./Dockerfile.linux \
    --build-arg raylib_cmake_args="-DBUILD_SHARED_LIBS=ON" \
    -t abeimler/simple-cppbuilder-raylib:linux-shared-libs .

#docker build --force-rm=true -f ./Dockerfile.linux --build-arg raylib_cmake_args="-DUSE_EXTERNAL_GLFW=ON" -t abeimler/simple-cppbuilder-raylib:linux-external-glfw .


docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg image_tag="emscripten" \
    --build-arg raylib_platform="Web" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING=ON" \
    -t abeimler/simple-cppbuilder-raylib:web .