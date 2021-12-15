#!/bin/bash

echo -e " * Generator:         ${CMAKE_GENERATOR}"
echo -e " * Build Type:        ${CMAKE_BUILD_TYPE}"
echo -e " * Toolchain:         ${CMAKE_TOOLCHAIN_FILE}"
echo -e " * raylib CMake Args: ${RAYLIB_CMAKE_ARGS} ${RAYLIB_ADDITIONAL_CMAKE_ARGS}"
echo -e " * CMake Args:        ${CMAKE_ARGS} ${ADDITIONAL_CMAKE_ARGS}"


$CMAKE -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${CMAKE_TOOLCHAIN_FILE}" \
    ${RAYLIB_CMAKE_ARGS} ${RAYLIB_ADDITIONAL_CMAKE_ARGS} \
    ${CMAKE_ARGS} ${ADDITIONAL_CMAKE_ARGS}

cd build
$MAKE "${TARGET}"