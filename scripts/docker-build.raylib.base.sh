#!/bin/bash

echo -e " * Generator:         ${CMAKE_GENERATOR}"
echo -e " * Build Type:        ${CMAKE_BUILD_TYPE}"
echo -e " * Toolchain:         ${CMAKE_TOOLCHAIN_FILE}"
echo -e " * raylib CMake Args: ${RAYLIB_CMAKE_ARGS} ${RAYLIB_ADDITIONAL_CMAKE_ARGS}"
echo -e " * CMake Args:        ${CMAKE_ARGS}"


$CMAKE -B "${RAYLIB_BINARY_DIR}" -S "${RAYLIB_SOURCE_DIR}" -G "${CMAKE_GENERATOR}" -DCMAKE_TOOLCHAIN_FILE="${CMAKE_TOOLCHAIN_FILE}" \
    ${RAYLIB_CMAKE_ARGS} \
    ${RAYLIB_ADDITIONAL_CMAKE_ARGS} \
    -DBUILD_EXAMPLES=OFF

$CMAKE --build ${RAYLIB_BINARY_DIR}