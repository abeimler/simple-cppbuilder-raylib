#!/bin/bash

docker-compose -f examples/example/docker-compose.yml up --build example-gcc-release-build-raylib
docker-compose -f examples/example/docker-compose.yml up --build example-mingw-release-build-raylib

docker-compose -f examples/example/docker-compose.yml up --build example-web-release-build-raylib

docker-compose -f examples/example/docker-compose.yml up --build example-rpi4-desktop-release-build-raylib
docker-compose -f examples/example/docker-compose.yml up --build example-rpi4-release-build-raylib
docker-compose -f examples/example/docker-compose.yml up --build example-rpi-release-build-raylib