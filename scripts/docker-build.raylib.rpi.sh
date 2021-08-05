#!/bin/bash

$CMAKE -B "${RAYLIB_BINARY_DIR}" -S "${RAYLIB_SOURCE_DIR}" -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
    -DCMAKE_C_FLAGS="-I/opt/vc/include" \
    -DCMAKE_CXX_FLAGS="-I/opt/vc/include" \
    -DCMAKE_LD_FLAGS="-L/opt/vc/lib" \
    ${RAYLIB_CMAKE_ARGS} \
    ${RAYLIB_ADDITIONAL_CMAKE_ARGS} \
    -DBUILD_EXAMPLES=OFF

cd "${RAYLIB_BINARY_DIR}" 
${MAKE} raylib