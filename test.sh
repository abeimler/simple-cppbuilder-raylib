#!/bin/bash

docker-compose -f examples/example/docker-compose.yml up --build example-gcc-release-build-raylib
docker-compose -f examples/example/docker-compose.yml up --build example-mingw-release-build-raylib


docker-compose -f examples/raylib-examples/docker-compose.yml up --build raylib-examples-gcc-release-build-raylib
docker-compose -f examples/raylib-examples/docker-compose.yml up --build raylib-examples-mingw-release-build-raylib

docker-compose -f examples/raylib-examples/docker-compose.yml up --build raylib-examples-web-release-build-raylib
docker-compose -f examples/raylib-examples/docker-compose.yml up --build raylib-examples-android-release-build-raylib

docker-compose -f examples/raylib-examples/docker-compose.yml up --build raylib-examples-rpi4-release-build-raylib
docker-compose -f examples/raylib-examples/docker-compose.yml up --build raylib-examples-rpi-release-build-raylib
docker-compose -f examples/raylib-examples/docker-compose.yml up --build raylib-examples-rpi4-desktop-release-build-raylib