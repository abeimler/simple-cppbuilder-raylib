#!/bin/bash

echo -e " * Generator:         ${CMAKE_GENERATOR}"
echo -e " * Build Type:        ${BUILD_TYPE}"
echo -e " * Toolchain:         ${TOOLCHAIN_FILE}"
echo -e " * raylib CMake Args: ${RAYLIB_CMAKE_ARGS} ${RAYLIB_ADDITIONAL_CMAKE_ARGS}"
echo -e " * CMake Args:        ${CMAKE_ARGS}"


$CMAKE -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
    -DCMAKE_C_FLAGS="-I${NATIVE_APP_GLUE_PATH}" \
    -DCMAKE_CXX_FLAGS="-I${NATIVE_APP_GLUE_PATH}" \
    ${RAYLIB_CMAKE_ARGS} ${RAYLIB_ADDITIONAL_CMAKE_ARGS} \
    ${CMAKE_ARGS}

cd build
$MAKE "${TARGET}"