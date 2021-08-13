#!/bin/bash

echo -e " * Generator:         ${CMAKE_GENERATOR}"
echo -e " * Build Type:        ${BUILD_TYPE}"
echo -e " * Toolchain:         ${TOOLCHAIN_FILE}"
echo -e " * raylib CMake Args: ${RAYLIB_CMAKE_ARGS} ${RAYLIB_ADDITIONAL_CMAKE_ARGS}"
echo -e " * CMake Args:        ${CMAKE_ARGS}"


$CMAKE -B "${RAYLIB_BINARY_DIR}" -S "${RAYLIB_SOURCE_DIR}" -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
    ${RAYLIB_CMAKE_ARGS} \
    ${RAYLIB_ADDITIONAL_CMAKE_ARGS} \
    -DBUILD_EXAMPLES=OFF

cd "${RAYLIB_BINARY_DIR}" 
$MAKE raylib