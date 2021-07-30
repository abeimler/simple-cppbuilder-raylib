#!/bin/bash

$CMAKE -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
    ${RAYLIB_CMAKE_ARGS} ${RAYLIB_ADDITIONAL_CMAKE_ARGS} \
    ${CMAKE_ARGS}

$CMAKE --build build --target "${TARGET}"

ctest --build-test --test-dir build